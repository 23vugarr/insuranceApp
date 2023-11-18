import 'package:pasha_insurance/mappers/base/base_mapper.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/models/response/car_list_response.dart';

class CarMapper implements BaseMapper<Car, CarModel> {
  @override
  CarModel convert(Car object) {
    return CarModel.fromJson(object.toJson());
  }
}