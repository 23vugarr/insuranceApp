// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasha_insurance/mappers/report_mapper.dart';
import 'package:pasha_insurance/models/data/report_model.dart';
import 'package:pasha_insurance/models/response/report_response.dart';
import 'package:pasha_insurance/services/API/user_service.dart';
import 'package:pasha_insurance/services/file_picker_service.dart';
import 'package:pasha_insurance/services/service_locator.dart';

class ReportState extends ChangeNotifier {
  final FilePickerService _filePickerService = locator<FilePickerService>();
  final UserService _userService = locator<UserService>();
  final ReportMapper _reportMapper = locator<ReportMapper>();

  File? _selectedFile;
  ReportModel? _lastReport;
  bool _isLoadingImage = false;
  bool _isReportLoading = false;

  Future<bool> pickImageFromGalery() async {
    _isLoadingImage = true;
    notifyListeners();

    _selectedFile = await _filePickerService.pickImage(ImageSource.gallery);

    _isLoadingImage = false;
    notifyListeners();

    return _selectedFile != null;
  }

  Future<bool> pickImageFromCamera() async {
    _isLoadingImage = true;
    notifyListeners();

    _selectedFile = await _filePickerService.pickImage(ImageSource.camera);

    _isLoadingImage = false;
    notifyListeners();

    return _selectedFile != null;
  }

  Future<ReportModel?> sendReport(BuildContext context, int carId) async {
    if (_selectedFile == null) return null;
    _isReportLoading = true;
    notifyListeners();

    final ReportResponse? resp = await _userService.sendDamageImage(context, _selectedFile!, carId);

    _isReportLoading = false;
    notifyListeners();

    if (resp?.result != null && !(resp?.hasErrors ?? true)) {
      _lastReport = _reportMapper.convert(resp!.result!);
      return _reportMapper.convert(resp.result!);
    } else {
      return null;
    }
  }

  Future<bool> confirmReport({required LatLng location, required bool callEvacuator}) async {
    return true;
  }

  File? get selectedFile => _selectedFile;
  bool get isLoading => _isLoadingImage;
  bool get isReportLoading => _isReportLoading;
}