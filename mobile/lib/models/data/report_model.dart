// ignore_for_file: non_constant_identifier_names

import 'package:pasha_insurance/models/data/base/base_data_model.dart';

class ReportModel extends BaseDataModel {
  final List<int>? damages;
  final List<int>? scratches;
  final List<int>? car_parts;
  final String? damages_info_str;
  final List<int>? overlayed_image;
  final DateTime? date;

  ReportModel({
    this.damages,
    this.scratches,
    this.car_parts,
    this.damages_info_str,
    this.overlayed_image,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'damages': damages,
      'scratches': scratches,
      'car_parts': car_parts,
      'damages_info_str': damages_info_str,
      'overlayed_image': overlayed_image,
      'date': date?.toIso8601String(),
    };
  }

  factory ReportModel.fromJson(Map<String, dynamic> map) {
    return ReportModel(
      damages: map['damages'] != null ? List<int>.from(map['damages'] as List<int>) : null,
      scratches: map['scratches'] != null ? List<int>.from(map['scratches'] as List<int>) : null,
      car_parts: map['car_parts'] != null ? List<int>.from(map['car_parts'] as List<int>) : null,
      damages_info_str: map['damages_info_str'] != null ? map['damages_info_str'] as String : null,
      overlayed_image: map['overlayed_image'] != null ? List<int>.from(map['overlayed_image'] as List<int>) : null,
      date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
    );
  }
}