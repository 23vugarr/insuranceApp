import 'package:pasha_insurance/models/response/base/base_api_response.dart';

class AuthResponse implements BaseApiResponse<Tokens>{
  @override
  bool? hasErrors;
  @override
  Tokens? result;

  AuthResponse({
    this.result,
    this.hasErrors,
  });

  AuthResponse.fromJson(Map<String, dynamic> json)
    : result = (json['result'] as Map<String,dynamic>?) != null ? Tokens.fromJson(json['result'] as Map<String,dynamic>) : null,
      hasErrors = json['result'] == null;

  @override
  Map<String, dynamic> toJson() => {
    'result' : result?.toJson(),
    'hasErrors' : hasErrors,  //?
  };
}

class Tokens {
  final String? accessToken;

  Tokens({
    this.accessToken,
  });

  Tokens.fromJson(Map<String, dynamic> json)
    : accessToken = json['access_token'] as String?;

  Map<String, dynamic> toJson() => {
    'access_token' : accessToken,
  };
}