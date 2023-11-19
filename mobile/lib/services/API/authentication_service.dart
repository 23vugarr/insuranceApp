import 'package:pasha_insurance/constants/strings/api_consts.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/enum/api_method.dart';
import 'package:pasha_insurance/models/req_dto/sign_in_req_dto.dart';
import 'package:pasha_insurance/models/req_dto/sign_up_req_dto.dart';
import 'package:pasha_insurance/models/response/auth_response.dart';
import 'package:pasha_insurance/services/API/base/base_api_service.dart';
import 'package:pasha_insurance/services/API/base/base_auth_service.dart';

class AuthenticationService extends BaseAPIService implements BaseAuthService {
  AuthenticationService() : super(path: ApiConsts.authenticationPath);

  @override
  Future<ApiResponseModel<Tokens>> signIn(SignInReqDTO signInReqDTO) async {
    return await makeApiRequest<Tokens>(
      path: serviceBuilder.addParam("login").build(), 
      apiMethod: ApiMethod.POST,
      data: signInReqDTO.toJson(),
      operate: (resp) {
        final AuthResponse authResponse = AuthResponse.fromJson(resp.data, false);
        if (!(authResponse.hasErrors ?? true)) {
          return authResponse.result!;
        }
        return null;
      },
    );
  }

  @override
  Future<ApiResponseModel<Tokens>> signUp(SignUpReqDTO signUpReqDTO) async {
    return await makeApiRequest<Tokens>(
      path: serviceBuilder.addParam("register").build(), 
      apiMethod: ApiMethod.POST,
      data: signUpReqDTO.toJson(),
      operate: (resp) {
        final AuthResponse authResponse = AuthResponse.fromJson(resp.data, true);
        if (!(authResponse.hasErrors ?? true)) {
          return authResponse.result;
        }
        return null;
      },
    );
  }
}