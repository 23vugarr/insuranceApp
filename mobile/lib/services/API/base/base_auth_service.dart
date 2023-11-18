import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/req_dto/sign_in_req_dto.dart';
import 'package:pasha_insurance/models/req_dto/sign_up_req_dto.dart';
import 'package:pasha_insurance/models/response/auth_response.dart';

abstract class BaseAuthService {
  Future<ApiResponseModel<Tokens>> signIn(SignInReqDTO signInReqDTO);

  Future<ApiResponseModel<Tokens>> signUp(SignUpReqDTO signUpReqDTO);
}
