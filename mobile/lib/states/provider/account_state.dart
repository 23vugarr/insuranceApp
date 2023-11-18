import 'package:flutter/material.dart';
import 'package:pasha_insurance/mappers/user_mapper.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/data/user_model.dart';
import 'package:pasha_insurance/models/response/user_response.dart';
import 'package:pasha_insurance/services/API/account_service.dart';
import 'package:pasha_insurance/services/service_locator.dart';

class AccountState extends ChangeNotifier {
  final AccountService _userService = locator<AccountService>();
  final UserMapper _userMapper = locator<UserMapper>();

  UserModel? _userModel;
  bool _isLoading = false;

  Future<void> fetchMe() async {
    _isLoading = true;
    notifyListeners();

    final ApiResponseModel<User> resp = await _userService.fetchMe();
    if (!resp.hasErrors) {
      _userModel = _userMapper.convert(resp.result!);
    }

    _isLoading = false;
    notifyListeners();
  }

  UserModel? get userModel => _userModel;  
  bool get isLoading => _isLoading;
}