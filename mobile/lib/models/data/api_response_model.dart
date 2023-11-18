import 'package:either_dart/either.dart';
import 'package:pasha_insurance/models/data/base/base_data_model.dart';
import 'package:pasha_insurance/models/response/error_response.dart';

class ApiResponseModel<T> extends BaseDataModel {
  late final Either<T?, ErrorResponse> _response;

  ApiResponseModel._({required Either<T?, ErrorResponse> response}) {
    _response = response;
  }

  factory ApiResponseModel.fromResponseModel(T? result) {
    return ApiResponseModel._(response: Left(result));
  }

  factory ApiResponseModel.fromError(ErrorResponse errorResponse) {
    return ApiResponseModel._(response: Right(errorResponse));
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  T? get result => _response.left;
  ErrorResponse get errorResponse => _response.right;
  bool get hasErrors => _response.isRight;
}