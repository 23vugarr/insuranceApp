// ignore_for_file: unused_field, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pasha_insurance/constants/strings/app_router_consts.dart';
import 'package:pasha_insurance/constants/strings/assets.dart';
import 'package:pasha_insurance/constants/style/animation_consts.dart';
import 'package:pasha_insurance/constants/style/app_text_styles.dart';
import 'package:pasha_insurance/models/enum/awareness_level.dart';
import 'package:pasha_insurance/states/provider/report_state.dart';
import 'package:pasha_insurance/states/provider/select_location_state.dart';
import 'package:pasha_insurance/ui/screens/home/home_screen.dart';
import 'package:pasha_insurance/ui/widgets/buttons/primary_button.dart';
import 'package:pasha_insurance/ui/widgets/custom/custom_map.dart';
import 'package:pasha_insurance/ui/widgets/dialog/result/result_dialog.dart';
import 'package:pasha_insurance/ui/widgets/dialog/result/success_dialog.dart';
import 'package:pasha_insurance/utils/helpers/app_loger.dart';
import 'package:pasha_insurance/utils/toast_notifier.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SelectAccidentLocationScreen extends StatefulWidget {
  final bool needToCallEvacuator;
  const SelectAccidentLocationScreen({super.key, required this.needToCallEvacuator});

  @override
  State<SelectAccidentLocationScreen> createState() => _SelectAccidentLocationScreenState();

  static void open(BuildContext context, {required bool needToCallEvacuator}) {
    context.push(AppRouterConsts.selectAccidentLocationPath, extra: {'needToCallEvacuator': needToCallEvacuator});
  }

}

class _SelectAccidentLocationScreenState extends State<SelectAccidentLocationScreen> {
  GoogleMapController? _mapController;
  late final SelectLocationState _selectLocationState;
  late final CameraPosition _initCameraPosition;
  
  @override
  void initState() {
    super.initState();
    _selectLocationState = Provider.of<SelectLocationState>(context, listen: false);
    _initCameraPosition = CameraPosition(
      target: _selectLocationState.defaultMapPosition,
      zoom: _selectLocationState.initZoom,
    );  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Accident location", style: AppTextStyles.headline2Size20)),
      body: _buildContent(),
    );
  }
  
  Widget _buildContent() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            Container(
              child: _buildMap(),
            ),
            _buildPointer(context),
            _buildMyLocationButton(),
            _buildSelectButton(),
          ],
        );
      }
    );
  }

  Widget _buildMap() {
    final SelectLocationState selectAccidentLocationScreen = Provider.of<SelectLocationState>(context, listen: false);
    return CustomMap(
      initialCameraPosition: _initCameraPosition,
      compassEnabled: true,
      mapToolbarEnabled: true,
      myLocationButtonEnabled: true,
      minZoom: selectAccidentLocationScreen.minZoom,
      maxZoom: selectAccidentLocationScreen.maxZoom,
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      onCameraIdle: _onCameraIdle,
      // onTap: _onMapTap,
    );
  }

  Widget _buildPointer(BuildContext scaffoldContext) {
    Duration animDuration = const Duration(milliseconds: 200);
    double animValue = 6;
    bool isCameraMoving = Provider.of<SelectLocationState>(context).isCameraMoving;

    return Positioned(
      left: 0,
      right: 0,
      bottom: (MediaQuery.of(scaffoldContext).size.height - (Scaffold.of(scaffoldContext).appBarMaxHeight ?? 0)) / 2, // (MediaQuery.of(context).size.height * 0.44),
      child: AnimatedContainer(
        curve: AnimationConsts.kAppAnimCurve,
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: isCameraMoving ? animValue : 0),
        child: AnimatedContainer(
          curve: AnimationConsts.kAppAnimCurve,
          duration: animDuration,
          height: isCameraMoving ? 37 + animValue : 37,
          child: SvgPicture.asset(Assets.locationPicker), // h: 37, w: 19
        ),
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _selectLocationState
      ..currentPosition = position.target
      ..setIsCameraMoving(true);
  }

  void _onCameraIdle() {
    _selectLocationState.setIsCameraMoving(false);
  }
  
  Widget _buildSelectButton() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 23 : 16,
      child: PrimaryButton(
        label: "SELECT",
        onTap: () {
          makeResultantRequest<bool>(context: context, 
            asyncRequest: Provider.of<ReportState>(context, listen: false).confirmReport(location: _selectLocationState.currentPosition!, callEvacuator: widget.needToCallEvacuator), 
            isSuccessful: (resp) => resp,
            onResult: (success, resp) async {
              if (success) {
                HomeScreen.open(context);
                ToastNotifier.showToast(message: "You successfully submitted the claim!", awarenessLevel: AwarenessLevel.SUCCESS);
                // await showSuccessDialog(context, title: "You successfully submitted the claim!");
              }
            },
            showDialogOnSuccess: false,
          );
        },
      ),
    );
  }

  void _moveToCurrentLocation() async {
    _requestLocationPermission();
    _getCurrentLocation();
  }
  
  Widget _buildMyLocationButton() {
    return Positioned(
      right: 16,
      top: 32,
      child: GestureDetector(
        onTap: _moveToCurrentLocation,
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.location_on_outlined, color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }

  void _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
    } else {
    }
  }

  void _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

    _mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(position.latitude, position.longitude),
        zoom: 17.0,
      ),
    ));
  }

}