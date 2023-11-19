// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pasha_insurance/mappers/tokens_mapper.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/data/tokens_model.dart';
import 'package:pasha_insurance/models/enum/state_types/auth_state_type.dart';
import 'package:pasha_insurance/models/req_dto/sign_in_req_dto.dart';
import 'package:pasha_insurance/models/req_dto/sign_up_req_dto.dart';
import 'package:pasha_insurance/models/response/auth_response.dart';
import 'package:pasha_insurance/services/API/authentication_service.dart';
import 'package:pasha_insurance/services/local/local_storage.dart';
import 'package:pasha_insurance/services/service_locator.dart';
import 'package:pasha_insurance/states/bloc/base/hydratable_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final LocalStorage _localStorage = locator<LocalStorage>();

  AuthBloc() : super(const NotAuthorizedState()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
  }

  FutureOr<void> _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(const LoadingState());
    final SignInReqDTO dto = SignInReqDTO(
      fin: event.finCode,
      password: event.password,
    );
    final ApiResponseModel<Tokens> resp = await _authenticationService.signIn(dto);
    _handleAuthResponse(resp, emit, isSignUp: false);
  }

  FutureOr<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(const LoadingState());
    final SignUpReqDTO dto = SignUpReqDTO(
      fin: event.finCode,
      phoneNumber: event.phoneNumber,
      password: event.password,
    );
    final ApiResponseModel<Tokens> resp = await _authenticationService.signUp(dto);
    _handleAuthResponse(resp, emit, isSignUp: true);
  }


  void _handleAuthResponse(ApiResponseModel<Tokens> resp, Emitter<AuthState> emit, {required bool isSignUp}) {
    if (resp.hasErrors) {
      emit(const FailedAuthorizationState()); 
      emit(const NotAuthorizedState());
    } else if (resp.result != null) {
      final TokensModel tokensModel = locator<TokensMapper>().convert(resp.result!);
      _localStorage.writeAccessToken(tokensModel.accessToken!);
      emit(AuthorizedState(tokensModel: tokensModel));
    } else {
      emit(const NotAuthorizedState());
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    AuthState? authState; 
    final String stateType = json['stateType']; 
    if (stateType == AuthStateType.AUTHORIZED.name) {
      authState = AuthorizedState.fromJson(json);
    } else if (stateType == AuthStateType.NOT_AUTHORIZED.name) {
      authState = NotAuthorizedState.fromJson(json);
    } 
    return authState;
  }
  
  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return [AuthStateType.AUTHORIZED, AuthStateType.NOT_AUTHORIZED].contains(state.stateType)
      ? (state.toJson()
        ?..addAll({
          'stateType': state.stateType.name
        }))
      : null;
  }
}
