import 'package:pasha_insurance/models/response/base/base_api_response.dart';

class CarListResponse implements BaseApiResponse<List<Car>> {
  @override
  bool? hasErrors;
  @override
  List<Car>? result;

  CarListResponse({
    this.hasErrors,
    this.result,
  });

  CarListResponse.fromJson(Map<String, dynamic> json)
    : result = (json['result'] as Map<String, dynamic>?) != null ? (json['result']!['cars'] as List?)?.map((e) => Car.fromJson(e)).toList() : null,
      hasErrors = json['result'] == null;

  @override
  Map<String, dynamic> toJson() => {
    'result' : result,
    'hasErrors' : hasErrors
  };
}

class Car {
  final int? id;
  final String? plateNumber;
  final int? year;
  final String? model;
  final String? color;

  Car({
    this.id,
    this.plateNumber,
    this.year,
    this.model,
    this.color,
  });

  Car.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      plateNumber = json['plateNumber'] as String?,
      year = json['year'] as int?,
      model = json['model'] as String?,
      color = json['color'] as String?;


  Map<String, dynamic> toJson() => {
    'id' : id,
    'plateNumber' : plateNumber,
    'year' : year,
    'model' : model,
    'color' : color,
  };
}