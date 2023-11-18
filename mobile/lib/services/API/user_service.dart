// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:pasha_insurance/constants/strings/api_consts.dart';
import 'package:pasha_insurance/models/data/api_response_model.dart';
import 'package:pasha_insurance/models/enum/api_method.dart';
import 'package:pasha_insurance/models/response/car_list_response.dart';
import 'package:pasha_insurance/services/API/base/base_api_service.dart';
import 'package:pasha_insurance/utils/helpers/app_loger.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pasha_insurance/states/bloc/auth/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService extends BaseAPIService {
  UserService() : super(path: ApiConsts.userPath);

  Future<ApiResponseModel<List<Car>>> fetchMyCars() async {
    return await makeApiRequest<List<Car>>(
      path: serviceBuilder.addParam("cars").build(), 
      apiMethod: ApiMethod.GET,
      operate: (resp) {
        final CarListResponse carResponse = CarListResponse.fromJson(resp.data);
        logger.i(carResponse.toJson());
        if (!(carResponse.hasErrors ?? true)) {
          return carResponse.result!;
        }
        return null;
      },
    );
  }

  Future<Uint8List?> sendDamageImage(BuildContext context, File file, int carId) async {
    logger.i(serviceBuilder.addParam("report").addParam(carId.toString()).build());
    var request = http.MultipartRequest('POST', Uri.parse(serviceBuilder.addParam("report").addParam(carId.toString()).build()));
    Map<String, String> headers = {"Authorization": "Bearer ${(context.read<AuthBloc>().state as AuthorizedState).tokensModel.accessToken}"};
    request.headers.addAll(headers);

    final String filePath = file.path;

    final String fileName = filePath.split("/").last;
    final String fileExtension = fileName.split('.').last;

    logger.i(filePath);
    logger.i(fileName);
    logger.i(fileExtension);

    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',
      filePath,
      filename: fileName,
      contentType: MediaType(
        "image",
        fileExtension,
      ),
    );
    request.files.add(multipartFile);

    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      var res = response.body;
      logger.i("multipart result -> ${res.length} $res");

      // if (res["statusCode"] == 200) {
      //   isSuccess = !res["isError"];
      // }
      // logger.i(response.body);
      // logger.i(jsonDecode(response.body));
      logger.i((jsonDecode(response.body) as List<dynamic>).map((e) => e as int).toList().length);
      return Uint8List.fromList((jsonDecode(response.body) as List<dynamic>).map((e) => e as int).toList());
    } catch (e) {
      logger.e("error on receipt uplaod  $e");
    }
    return null;  
  }
}