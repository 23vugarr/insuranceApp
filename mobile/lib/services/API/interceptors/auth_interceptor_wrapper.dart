// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart'; 
import 'package:pasha_insurance/models/enum/api_method.dart';
import 'package:pasha_insurance/services/API/authentication_service.dart';
import 'package:pasha_insurance/services/local/local_storage.dart';
import 'package:pasha_insurance/services/service_locator.dart';
import 'package:pasha_insurance/utils/helpers/app_loger.dart';
import 'package:pasha_insurance/utils/app_router.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  // static BuildContext? context;

  AuthInterceptorsWrapper() : super(
    onRequest: _onRequest,
    onResponse: _onResponse,
    onError: _onError,
  );

  void init(BuildContext context) {
    // AuthInterceptorsWrapper.context ??= context;
  }

  // static BuildContext getContext() {
  //   final BuildContext? context = AuthInterceptorsWrapper.context;
  //   if (context == null) {
  //     throw Exception("AuthInterceptorWrapper has not been initialized! (context == null)");
  //   }
  //   return context;
  // }

  static final AuthenticationService _accountService = locator<AuthenticationService>();
  static final LocalStorage _localStorage = locator<LocalStorage>();
  // static bool _isCallRefreshInProgress = false;
  // static bool _isRefreshFrozen = false;

  static void _onResponse(Response<dynamic> resp, ResponseInterceptorHandler handler) {
    List<String> logInPathList = ["login", "register"];

    bool isLogingIn = false;
    for (String path in logInPathList) {
      isLogingIn = resp.requestOptions.path.contains(path);
      if (isLogingIn) break;
    }

    return handler.next(resp);
  }

  static void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains("login") || options.path.contains("register")) {
      options.headers.removeWhere((key, value) => !["accept", "content-type"].contains(key));
    } else {
      final String accessToken = _localStorage.accessToken ?? "";
      options.headers["Authorization"] = "Bearer $accessToken";
    }
    return handler.next(options);
  }

  static Future<dynamic> _onError(DioException e, ErrorInterceptorHandler handler) async {
    logger.e("DioError's statucCode is ${e.response?.statusCode} on path ${e.requestOptions.path}");

    String path = e.requestOptions.path;
    if (path.contains("login") || path.contains("register")) {
      // final String errorMessage = e.response?.data["responseException"] != null
      //   ? e.response!.data["responseException"]["exceptionMessage"]
      //   : e.message ?? "Unhandled Exception!";
      // await ToastService.showTimeAdjustedToast(message: errorMessage, awarenessLevel: AwarenessLevel.ERRROR);
      return handler.next(e);
    }

    switch (e.response?.statusCode) {
      case 401:
        return await _handleUnauthorizedError(e, handler);
      case 400:
        if (e.requestOptions.path.contains("refresh-token")) {
          DioException? err = await _handleRefreshTokenError(e, handler);
          return handler.reject(err);
        }
      default:
        return handler.reject(e);
    }
  }

  static Future<dynamic> _handleUnauthorizedError(DioException e, ErrorInterceptorHandler handler) async {
    logger.d("Handling UNauthorized status code - 401");
    // await _refreshToken();
    // await Future.delayed(const Duration(seconds: 1));
    // final bool isRefreshSuccess = getContext().read<AuthState>() is AuthorizedState;
    // if (isRefreshSuccess) {
    //   logger.d("Tokens has been refreshed successfully");
    //   return await _retry(e.requestOptions, handler);
    // } else {
    //   logger.e("Token refreshing failed");
    //   await _logout();
    //   return _getRefreshTokenError(e);
    // }
    await _logout();
  }

  static Future<DioException> _handleRefreshTokenError(DioException e, ErrorInterceptorHandler handler) async {
    logger.d("Handling BadRequest status code - 400, on refresh-token");
    await _logout();
    return _getRefreshTokenError(e);
  }

  static DioException _getRefreshTokenError(DioException e) {
    e.requestOptions.extra["tokenErrorType"] = "Failed to refresh tokens";
    return e;
  }

  static Future<void> _retry(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    logger.d("Retrying request (to ${requestOptions.path})");
    final Options options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    final ApiResponseModel resp = await _accountService.makeApiRequest<Response>(
      apiMethod: ApiMethod.values.firstWhere(
        (e) => e.name.toUpperCase() == requestOptions.method.toUpperCase(),
      ),
      path: requestOptions.path,
      queryParameters: requestOptions.queryParameters,
      data: requestOptions.data,
      options: options,
      operate: (resp) => resp,
    );
    final Response clone = resp.result!; //?
    return handler.resolve(clone);
  }

  // static Future<void> _refreshToken() async {
  //   logger.d("Calling _refreshToken method --> InProgress: $_isCallRefreshInProgress");

  //   while (!_isCallRefreshInProgress) {
  //     _isCallRefreshInProgress = true;
  //     logger.d("Calling _refreshToken Loop --> Frozen: $_isRefreshFrozen");
  //     if (!_isRefreshFrozen) {
  //       _freezeTokenRefresh();
  //       logger.d("Refreshing tokens");
  //       final String curRefreshToken = (getContext().read<AuthBloc>().state as AuthorizedState).tokensModel.refreshToken!;
  //       getContext().read<AuthBloc>().add(RefreshTokenEvent(refreshToken: curRefreshToken));
  //       _isCallRefreshInProgress = false;

  //       break;
  //     }
  //     await Future.delayed(const Duration(milliseconds: 1000));
  //   }
  //   while (_isCallRefreshInProgress) {
  //     await Future.delayed(const Duration(milliseconds: 1000));
  //   }
  // }

  // static void _freezeTokenRefresh() {
  //   _isRefreshFrozen = true;
  //   logger.d("refreshToken -> frozen");
  //   Future.delayed(const Duration(seconds: 5)).then((value) {
  //     _isRefreshFrozen = false;
  //     logger.d("refreshToken -> unfrozen");
  //   });
  // }

  static Future<void> _logout() async {
    logger.d("Logging out");

    await _localStorage.clearAllData();
    locator<AppRouter>().navigatorKey.currentState?.pushNamedAndRemoveUntil("/", (route) => false);  //?
  }
}
