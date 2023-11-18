import 'package:pasha_insurance/models/response/base/base_api_response.dart';

class ErrorResponse implements BaseApiResponse<dynamic> {
  @override
  bool? hasErrors;
  @override
  dynamic result;

  ErrorResponse({
    this.hasErrors,
    this.result,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json)
    : result = json['result'],
      hasErrors = json['hasErrors'] as bool?;

  @override
  Map<String, dynamic> toJson() => {
    'result' : result,
    'hasErrors' : hasErrors
  };
}