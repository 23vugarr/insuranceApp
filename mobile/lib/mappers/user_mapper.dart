import 'package:pasha_insurance/mappers/base/base_mapper.dart';
import 'package:pasha_insurance/models/data/user_model.dart';

import '../models/response/user_response.dart';

class UserMapper implements BaseMapper<User, UserModel> {
  @override
  UserModel convert(User object) {
    return UserModel.fromJson(object.toJson());
  }
}