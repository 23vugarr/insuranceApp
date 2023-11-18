// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasha_insurance/constants/style/animation_consts.dart';
import 'package:pasha_insurance/constants/style/app_colors.dart';
import 'package:pasha_insurance/states/cubit/drawer_wrapper/drawer_wrapper_cubit.dart';

// gives an ability to manipulate Drawer from outside 
class DrawerWrapperController {
  final bool initiallyOpened;
  BuildContext? _cubitContext;
  Animation<double>? _animation;
  bool _isDisposed = false;

  DrawerWrapperController({this.initiallyOpened = false});

  void open() {
    _checkIsDisposed();
    _getCubit().openDrawer();
  }

  void close() {
    _checkIsDisposed();
    _getCubit().closeDrawer();
  }


  DrawerWrapperCubit _getCubit() {
    _checkIsDisposed();
    if (_cubitContext == null)  throw Exception("Controller cannot be used until widget is builded!");
    return _cubitContext!.read<DrawerWrapperCubit>();
  }

  void _checkIsDisposed() => (_isDisposed ? throw Exception("Controller has been disposed!") : null);

  void dispose() {
    _cubitContext = null;
    _animation = null;
    _isDisposed = true;
  }

  void _setCubitContext(BuildContext context) => _cubitContext ??= context;
  void _setAnimation(Animation<double> animation)  => _animation = animation;
  
  bool get isOpened => _getCubit().state is OpenTriggeredDrawerState;
  Animation<double>? get animation => _animation;
}

class DrawerWrapper extends StatefulWidget {
  final DrawerWrapperController? controller;
  final double? drawerWidth;
  final BoxConstraints? drawerConstrains;
  final double bodyOffsetRatio;
  final double bodyOpacityRatio;
  final Color opacityColor;
  final Widget drawer;
  final double drawerClosingRatioAfterDrag;
  final double drawerTriggeringVelovityAfterDrag;
  final Widget Function(DrawerWrapperController controller) builder;
  final bool isDrawerOnLeft;
  final bool openOnDrag;
  final bool closeOnPop;

  const DrawerWrapper({super.key,
    this.controller,
    required this.drawer,
    required this.builder,
    this.drawerWidth,
    this.drawerConstrains,
    this.bodyOffsetRatio = 0.1,
    this.bodyOpacityRatio = 0.5,
    this.drawerClosingRatioAfterDrag = 0.5,
    this.drawerTriggeringVelovityAfterDrag = 600,
    this.opacityColor = AppColors.black, 
    this.isDrawerOnLeft = true,
    this.openOnDrag = false,
    this.closeOnPop = true,
  });

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> with SingleTickerProviderStateMixin {
  late final DrawerWrapperController _controller;

  late final AnimationController _animationController;
  late final Animation<double> _animation;

  double? _horizontalDragInitialDx;
  double? _horizontalDragInitialAnimControllerValue;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DrawerWrapperController();
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationConsts.kAppAnimDuration,
      reverseDuration: AnimationConsts.kAppAnimDuration,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: AnimationConsts.kAppAnimCurve,
      reverseCurve: AnimationConsts.kAppAnimCurve,
    ));
    _controller._setAnimation(_animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerWrapperCubit(initiallyOpened: _controller.initiallyOpened),
      child: WillPopScope(
        onWillPop: widget.closeOnPop && !Platform.isIOS ? _onWillPop : null,
        child: BlocConsumer<DrawerWrapperCubit, DrawerWrapperState>(
          listener: _blocListener,
          builder: _blocBuilder, 
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_controller.isOpened) {
      _controller.close();
      return false;
    } 
    return true;
  }

  void _blocListener(context, state) {
    state is OpenTriggeredDrawerState
      ? _animationController.forward()
      : _animationController.reverse();
  }

  Widget _blocBuilder(context, state) {
    return Builder(
      builder: (context) {
        _controller._setCubitContext(context);  //!

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            final bool isDragEnabled = widget.openOnDrag || _animation.value > 0.0;
            return GestureDetector(
              onHorizontalDragDown: isDragEnabled ? _onHorizontalDragDown : null,
              onHorizontalDragUpdate: isDragEnabled ?  _onHorizontalDragUpdate : null,
              onHorizontalDragEnd: isDragEnabled ? _onHorizontalDragEnd : null,
              child: Stack(
                children: [
                  _buildBackgroundWidget(context, state),
                  _buildDrawerWidget(context, state)
                ],
              ),
            );
          },
        );
      }
    );
  }

  void _onHorizontalDragDown(DragDownDetails details) {
    _animationController.stop();
    _horizontalDragInitialDx = details.globalPosition.dx;
    _horizontalDragInitialAnimControllerValue = _animationController.value;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_horizontalDragInitialDx == null || _horizontalDragInitialAnimControllerValue == null)  return;

    final double dx = (details.globalPosition.dx - _horizontalDragInitialDx!) * (widget.isDrawerOnLeft ? 1 : -1);
    if (dx != 0.0) {
      final double animValueDiff = dx / _getDrawerWidth(context);
      final double newAnimValue = _horizontalDragInitialAnimControllerValue! + animValueDiff;
      _animationController.value = _getBoundedAnimValue(newAnimValue);
    }
  }

  void _onHorizontalDragEnd(details) {
    final double velocityOnX = details.primaryVelocity ?? 0;

    if (velocityOnX.abs() >= widget.drawerTriggeringVelovityAfterDrag) {
      if (velocityOnX.isNegative) {
        widget.isDrawerOnLeft ? _controller.close() : _controller.open();
      } else {
        widget.isDrawerOnLeft ? _controller.open() : _controller.close();
      }
    } else if (_animationController.value <= widget.drawerClosingRatioAfterDrag) {
      _controller.close();
    } else {
      _controller.open();
    }
  }

  Positioned _buildBackgroundWidget(BuildContext context, DrawerWrapperState state) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: widget.isDrawerOnLeft ? _animation.value * widget.bodyOffsetRatio * MediaQuery.of(context).size.width : null,
      right: !widget.isDrawerOnLeft ? _animation.value * widget.bodyOffsetRatio * MediaQuery.of(context).size.width : null,
      child: GestureDetector(
        onTap: state is OpenTriggeredDrawerState
          ? _controller.close
          : null, 
        child: AbsorbPointer(
          absorbing: state is OpenTriggeredDrawerState,
          child: Stack(
            children: [
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: widget.builder(_controller)
              ),
              IgnorePointer(
                child: Opacity(
                  opacity: _animation.value * widget.bodyOpacityRatio,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: widget.opacityColor
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildDrawerWidget(BuildContext context, DrawerWrapperState state) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: widget.isDrawerOnLeft ? (_animation.value - 1) * _getDrawerWidth(context) : null,
      right: !widget.isDrawerOnLeft ? (_animation.value - 1) * _getDrawerWidth(context) : null,
      child: AbsorbPointer(
        absorbing: state is OpenTriggeredDrawerState,
        child: Container(
          constraints: widget.drawerConstrains,
          width: _getDrawerWidth(context),
          child: widget.drawer,
        ),
      ),
    );
  }

  double _getBoundedAnimValue(double newAnimValue) {
    return newAnimValue > 1
      ? 1.0
      : newAnimValue < 0
        ? 0.0
        : newAnimValue;
  }

  double _getDrawerWidth(BuildContext context) => widget.drawerWidth ?? MediaQuery.of(context).size.width;
}