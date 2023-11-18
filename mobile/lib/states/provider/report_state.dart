import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasha_insurance/services/API/user_service.dart';
import 'package:pasha_insurance/services/file_picker_service.dart';

class ReportState extends ChangeNotifier {
  final FilePickerService _filePickerService = FilePickerService();
  final UserService _userService = UserService();

  File? _selectedFile;
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

  Future<Uint8List?> sendReport(BuildContext context, int carId) async {
    if (_selectedFile == null) return null;
    _isReportLoading = true;
    notifyListeners();

    final Uint8List? bytes = await _userService.sendDamageImage(context, _selectedFile!, carId);

    _isReportLoading = false;
    notifyListeners();

    return bytes;
  }

  File? get selectedFile => _selectedFile;
  bool get isLoading => _isLoadingImage;
  bool get isReportLoading => _isReportLoading;
}