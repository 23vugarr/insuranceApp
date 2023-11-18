// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/enum/api_method.dart';
import 'package:pasha_insurance/models/enum/api_schema.dart';
import 'package:pasha_insurance/models/response/error_response.dart';
import 'package:pasha_insurance/services/API/interceptors/auth_interceptor_wrapper.dart';
import 'package:pasha_insurance/services/service_locator.dart';
import 'package:pasha_insurance/utils/helpers/app_loger.dart';
import 'package:pasha_insurance/utils/helpers/endpoint_builder.dart';


abstract class BaseAPIService {
  final Dio dio = locator<Dio>();
  final EndpointBuilder serviceBuilder = EndpointBuilder();

  BaseAPIService({String? path}) {
    if (path != null) {
      serviceBuilder.setSchema(schema: ApiSchema.HTTP).addParam(path).saveCurrentParams();
    }
    dio.interceptors.addAll([
      locator<AuthInterceptorsWrapper>()
    ]);
  }

  Future<ApiResponseModel<T>> makeApiRequest<T>({
    ApiMethod apiMethod = ApiMethod.GET,
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    required FutureOr<T?> Function(Response resp) operate,
    void Function(Object e)? onOperateException,
    bool logOnDioException = true,
  }) async {
    try {
      late final Response response;
      switch (apiMethod) {
        case ApiMethod.GET:
          response = await dio.get(path, queryParameters: queryParameters, options: options);
          break;
        case ApiMethod.POST:
          response = await dio.post(path, queryParameters: queryParameters, options: options, data: data);
          break;
        case ApiMethod.PUT:
          response = await dio.put(path, queryParameters: queryParameters, options: options, data: data);
          break;
        case ApiMethod.DELETE:
          response = await dio.delete(path, queryParameters: queryParameters, options: options, data: data);
          break;
        case ApiMethod.PATCH:
          response = await dio.patch(path, queryParameters: queryParameters, options: options, data: data);
          break;
        case ApiMethod.HEAD:
          response = await dio.head(path, queryParameters: queryParameters, options: options, data: data);
          break;
        default:
          logger.e("$apiMethod wasn't mapped in switch block -> default: dio.get()");
          response = await dio.get(path, queryParameters: queryParameters, options: options);
      } 
      return ApiResponseModel.fromResponseModel(await operate(response));
    } on DioException catch (e) {
      final ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data ?? {"hasErrors": true});
      if (logOnDioException) {
        logger.e("API error -> $path");
        logger.e(e.toString());
        logger.e(errorResponse.toJson());
      }
      return ApiResponseModel.fromError(errorResponse);
    } catch (e) {
      onOperateException?.call(e);
    }
    return ApiResponseModel.fromResponseModel(null);
  }
}