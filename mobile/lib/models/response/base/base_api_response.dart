abstract class BaseApiResponse<T> {
  // int? status;
  bool? hasErrors;
  T? result;

  BaseApiResponse.fromJson(Map<String, dynamic> json);  //?
  
  Map<String, dynamic> toJson();
}