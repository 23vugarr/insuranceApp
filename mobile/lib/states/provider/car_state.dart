import 'package:flutter/material.dart';
import 'package:pasha_insurance/mappers/car_mapper.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/models/response/car_list_response.dart';
import 'package:pasha_insurance/services/API/user_service.dart';
import 'package:pasha_insurance/services/service_locator.dart';

class CarState extends ChangeNotifier {
  final UserService _carService = locator<UserService>();
  final CarMapper _carMapper = locator<CarMapper>();

  List<CarModel>? _carList;
  bool _isLoading = false;

  Future<void> fetchMyCars() async {
    _isLoading = true;
    notifyListeners();

    // _carList = List.generate(10, (index) => index).map((i) {
    //   return CarModel(
    //     model: "Elantra - $i",
    //     plateNumber: "10-AA-111",
    //     year: 2000 + i,
    //   );
    // }).toList();
    final ApiResponseModel<List<Car>> resp = await _carService.fetchMyCars();
    if (!resp.hasErrors) {
      _carList = resp.result!.map((e) => _carMapper.convert(e)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<CarModel>? get carList => _carList;  
  bool get isLoading => _isLoading;
}