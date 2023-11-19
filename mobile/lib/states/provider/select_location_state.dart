import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationState with ChangeNotifier {   
  final LatLng defaultMapPosition = const LatLng(40.4093, 49.8671);
  
  final double initZoom = 16;
  final double minZoom = 10;
  final double maxZoom = 20;  

  bool _isCameraMoving = false;
  LatLng? currentPosition; 

  void setIsCameraMoving(bool isMoving) {
    _isCameraMoving = isMoving;
    notifyListeners();
  } 
 
  bool get isCameraMoving => _isCameraMoving; 
}