import 'package:flutter/material.dart';
import 'package:pasha_insurance/constants/style/animation_consts.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/states/provider/account_state.dart';
import 'package:pasha_insurance/ui/widgets/custom/drawer_wrapper.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final DrawerWrapperController drawerWrapperController;
  
  const HomeAppBar({super.key, required this.drawerWrapperController});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  bool _isSearchInvolved = false; // todo: need to write bloc/cubit for this

  final double _horizontalPadding = 12;
  final double _iconSize = 25;

  @override
  void initState() {
    super.initState();
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
  }

  void toggleDrawer() {
    widget.drawerWrapperController.isOpened
      ? widget.drawerWrapperController.close()
      : widget.drawerWrapperController.open();
  }

  @override
  Widget build(BuildContext context) {  // todo: need to handle willPop
    return AppBar(
      leading: _buildLeadingMenuButton(),
      leadingWidth: _horizontalPadding + _iconSize,
      title: _buildTitle(),
      actions: _buildActions(),
    );
  }

  Widget _buildLeadingMenuButton() {
    return GestureDetector(
      onTap: _isSearchInvolved 
        ? () {
          _animationController.reverse()
            .then((value) => 
              setState(() {
                _isSearchInvolved = false;
              })
            );
        } 
        : toggleDrawer,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.only(left: _horizontalPadding),
        child: SizedBox(
          child: _isSearchInvolved
            ? Center(child: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: _animation, size: _iconSize))
            : widget.drawerWrapperController.animation != null  
              ? Center(child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: widget.drawerWrapperController.animation!, size: _iconSize))
              : Icon(Icons.menu, size: _iconSize)
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return AnimatedSwitcher(
      duration: AnimationConsts.kAppAnimDuration,
      reverseDuration: AnimationConsts.kAppAnimDuration,
      switchInCurve: AnimationConsts.kAppAnimCurve,
      switchOutCurve: AnimationConsts.kAppAnimCurve,
      child: Text(_isSearchInvolved ? "" : "Welcome, ${Provider.of<AccountState>(context).userModel?.name}", style: AppTextStyles.headline2Size20),
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: EdgeInsets.only(right: _horizontalPadding),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSearchInvolved = true;
          });
          _animationController.forward();
        },
        behavior: HitTestBehavior.translucent,
        child: Icon(Icons.search_rounded, size: _iconSize),
      ),
    );
  }

  List<Widget>? _buildActions() {
    return [AnimatedSwitcher(
      duration: AnimationConsts.kAppAnimDuration,
      reverseDuration: AnimationConsts.kAppAnimDuration,
      switchInCurve: AnimationConsts.kAppAnimCurve,
      switchOutCurve: AnimationConsts.kAppAnimCurve,
      child: _isSearchInvolved ? null : _buildSearchButton(),
    )];
  }
}