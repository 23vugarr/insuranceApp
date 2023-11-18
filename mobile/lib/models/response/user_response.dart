import 'package:pasha_insurance/models/response/base/base_api_response.dart';

class UserResponse implements BaseApiResponse<User> {
  @override
  bool? hasErrors;
  @override
  User? result;

  UserResponse({
    this.hasErrors,
    this.result,
  });

  UserResponse.fromJson(Map<String, dynamic> json)
    : result = (json['result'] as Map<String, dynamic>?) != null ? User.fromJson(json['result']!['user']) : null,
      hasErrors = json['result'] == null;

  @override
  Map<String, dynamic> toJson() => {
    'result' : result,
    'hasErrors' : hasErrors
  };
}

class User {
  final String? id;
  final String? name;
  final String? surname;
  final String? phoneNumber;
  final String? fin;

  User({
    this.id,
    this.phoneNumber,
    this.fin,
    this.name,
    this.surname,
  });

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      phoneNumber = json['phoneNumber'] as String?,
      fin = json['fin'] as String?,
      surname = json['surname'] as String?,
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'phoneNumber' : phoneNumber,
    'fin' : fin,
    'name' : name,
    'surname' : surname,
  };
}