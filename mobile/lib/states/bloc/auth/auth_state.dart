part of 'auth_bloc.dart';

abstract class AuthState extends Equatable implements HydratableState {
  final AuthStateType stateType;

  const AuthState(this.stateType);
  
  @override
  List<Object> get props => [stateType];
}

class NotAuthorizedState extends AuthState {
  const NotAuthorizedState() : super(AuthStateType.NOT_AUTHORIZED);

  static NotAuthorizedState? fromJson(Map<String, dynamic> json) {
    return const NotAuthorizedState();
  }

  @override
  Map<String, dynamic>? toJson() {
    return <String, dynamic>{};
  }

  @override
  List<Object> get props => super.props + [];
}

class AuthorizedState extends AuthState {
  final TokensModel tokensModel;

  const AuthorizedState({required this.tokensModel}) : super(AuthStateType.AUTHORIZED);

  static AuthorizedState? fromJson(Map<String, dynamic> json) {
    return AuthorizedState(
      tokensModel: TokensModel.fromJson(json['tokensModel']),
    );
  }

  @override
  Map<String, dynamic>? toJson() {
    return <String, dynamic>{
      'tokensModel': tokensModel.toJson(),
    };
  }
  
  @override
  List<Object> get props => super.props + [tokensModel];
}

class FailedAuthorizationState extends AuthState {
  // final int? httpStatusCode; 
  // final bool fromRefreshToken;

  const FailedAuthorizationState() : super(AuthStateType.FAILED_AUTHORIZATION);

  @override
  List<Object> get props => super.props;

  static FailedAuthorizationState? fromJson(Map<String, dynamic> json) {
    return FailedAuthorizationState(
      // httpStatusCode: json['httpStatusCode'],
      // fromRefreshToken: json['fromRefreshToken'],
    );
  }

  @override
  Map<String, dynamic>? toJson() {
    return <String, dynamic>{
      // 'httpStatusCode': httpStatusCode,
    };
  }
}

class LoadingState extends AuthState {
  const LoadingState() : super(AuthStateType.LOADING);

  @override
  List<Object> get props => super.props + [];

  @override
  Map<String, dynamic>? toJson() {
    return <String, dynamic>{};
  }
}