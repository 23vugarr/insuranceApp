import 'package:pasha_insurance/models/data/base/base_data_model.dart';

class CarModel extends BaseDataModel {
  final int? id;
  final String? plateNumber;
  final int? year;
  final String? model;
  final String? color;

  CarModel({
    this.id,
    this.plateNumber,
    this.year,
    this.model,
    this.color,
  });

  CarModel.fromJson(Map<String, dynamic> json)
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