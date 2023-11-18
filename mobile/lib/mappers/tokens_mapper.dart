import 'package:pasha_insurance/mappers/base/base_mapper.dart';
import 'package:pasha_insurance/models/data/tokens_model.dart';
import 'package:pasha_insurance/models/response/auth_response.dart';

class TokensMapper implements BaseMapper<Tokens, TokensModel> {
  @override
  TokensModel convert(Tokens object) {
    return TokensModel.fromJson(object.toJson());
  }
}