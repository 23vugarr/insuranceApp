// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  final double? minZoom;
  final double? maxZoom;
  final CameraPosition initialCameraPosition;
  final void Function(GoogleMapController)? onMapCreated;
  final void Function(CameraPosition)? onCameraMove;
  final void Function()? onCameraIdle;
  final void Function(LatLng)? onTap;
  final Set<Marker>? markers;
  final Set<Polygon>? polygons;
  final Set<Polyline>? polylines;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final bool zoomControlsEnabled;
  final bool myLocationButtonEnabled; 
  final bool? myLocationEnabled; 

  const CustomMap({super.key, 
    required this.initialCameraPosition, 
    this.minZoom, 
    this.maxZoom, 
    this.onMapCreated, 
    this.onCameraMove, 
    this.onCameraIdle, 
    this.onTap, 
    this.markers, 
    this.polygons, 
    this.polylines,
    this.compassEnabled = false, 
    this.mapToolbarEnabled = false,  
    this.zoomControlsEnabled = false,  
    this.myLocationButtonEnabled = false, 
    this.myLocationEnabled, 
  });

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {

  // late final String _mapStyleDark;
  GoogleMapController? _controller;

  @override
  void initState() {
    super.initState(); 
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   rootBundle.loadString(Assets.mapStyleDark).then((string) {
    //     _mapStyleDark = string;
    //     _changeMapStyle(_controller);
    //   });
    // });
  } 

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: widget.initialCameraPosition,
      minMaxZoomPreference: MinMaxZoomPreference(widget.minZoom, widget.maxZoom),
      myLocationButtonEnabled: widget.myLocationButtonEnabled,
      zoomControlsEnabled: widget.zoomControlsEnabled,
      mapToolbarEnabled: widget.mapToolbarEnabled,
      compassEnabled: widget.compassEnabled,
      // myLocationEnabled: widget.myLocationEnabled ?? Provider.of<AddressState>(context).isLocationPermissionGranted,
      myLocationEnabled: widget.myLocationEnabled ?? false,
      markers: widget.markers ?? {},
      polygons: widget.polygons ?? {},
      polylines: widget.polylines ?? {},
      onTap: widget.onTap,
      onCameraIdle: widget.onCameraIdle,
      onCameraMove: widget.onCameraMove,
      onMapCreated: (controller) {
        // _changeMapStyle(controller);
        _controller = controller;
        widget.onMapCreated?.call(controller);
      },
    );
  }

  // void _changeMapStyle(GoogleMapController? controller) {
  //   if(controller == null)  return;
  //   _isLightTheme
  //     ? controller.setMapStyle(null) 
  //     : controller.setMapStyle(_mapStyleDark); 
  // }

}