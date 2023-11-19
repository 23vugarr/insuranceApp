import 'package:pasha_insurance/mappers/base/base_mapper.dart';
import 'package:pasha_insurance/models/data/report_model.dart';
import 'package:pasha_insurance/models/response/report_response.dart';

class ReportMapper implements BaseMapper<Report, ReportModel> {
  @override
  ReportModel convert(Report object) {
    return ReportModel.fromJson(object.toJson());
  }
}