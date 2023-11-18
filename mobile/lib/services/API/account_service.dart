import 'package:pasha_insurance/constants/strings/api_consts.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/enum/api_method.dart';
import 'package:pasha_insurance/models/response/user_response.dart';
import 'package:pasha_insurance/services/API/base/base_api_service.dart';

class AccountService extends BaseAPIService {
  AccountService() : super(path: ApiConsts.accountPath);

  Future<ApiResponseModel<User>> fetchMe() async {
    return await makeApiRequest<User>(
      path: serviceBuilder.addParam("information").build(), 
      apiMethod: ApiMethod.GET,
      operate: (resp) {
        final UserResponse userResponse = UserResponse.fromJson(resp.data);
        if (!(userResponse.hasErrors ?? true)) {
          return userResponse.result!;
        }
        return null;
      },
    );
  }
}