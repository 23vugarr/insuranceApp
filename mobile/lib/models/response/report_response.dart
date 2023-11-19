// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:pasha_insurance/models/response/base/base_api_response.dart';
import 'package:pasha_insurance/utils/helpers/app_loger.dart';

class ReportResponse implements BaseApiResponse<Report> {
  @override
  bool? hasErrors;
  @override
  Report? result;

  ReportResponse({
    this.hasErrors,
    this.result,
  });

  ReportResponse.fromJson(Map<String, dynamic> json)
    : result = (json['result'] as Map<String, dynamic>?) != null ? Report.fromJson(json['result']) : null,
      hasErrors = json['result'] == null;

  @override
  Map<String, dynamic> toJson() => {
    'result' : result,
    'hasErrors' : hasErrors
  };
}

class Report {
  final List<int>? damages;
  final List<int>? scratches;
  final List<int>? car_parts;
  final String? damages_info_str;
  final List<int>? overlayed_image;
  final DateTime? date;

  Report({
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

  factory Report.fromJson(Map<String, dynamic> map) {
    return Report(
      damages: map['damages'] != null ? (map['damages'] as List<dynamic>).map<int>((e) => e).toList() : null,
      scratches: map['scratches'] != null ? (map['scratches'] as List<dynamic>).map<int>((e) => e).toList() : null,
      car_parts: map['car_parts'] != null ? (map['car_parts'] as List<dynamic>).map<int>((e) => e).toList() : null,
      damages_info_str: map['damages_info_str'] != null ? map['damages_info_str'] as String : null,
      overlayed_image: map['overlayed_image'] != null ? (map['overlayed_image'] as List<dynamic>).map<int>((e) => e).toList() : null,
      date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
    );
  }
}
