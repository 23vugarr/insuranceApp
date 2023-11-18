import 'package:pasha_insurance/models/data/base/base_data_model.dart';

class TokensModel extends BaseDataModel {
  final String? accessToken;

  TokensModel({
    this.accessToken,
  });

  TokensModel.fromJson(Map<String, dynamic> json)
    : accessToken = json['access_token'] as String?;

  @override
  Map<String, dynamic> toJson() => {
    'access_token' : accessToken,
  };
}