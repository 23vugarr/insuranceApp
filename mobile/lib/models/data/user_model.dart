import 'package:pasha_insurance/models/data/base/base_data_model.dart';

class UserModel extends BaseDataModel {
  final String? name;
  final String? surname;
  final String? phoneNumber;
  final String? finCode;
  // final UserDetailsModel? userDetails;

  UserModel({
    this.name,
    this.surname,
    this.phoneNumber,
    this.finCode,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String?,
      surname = json['surname'] as String?,
      phoneNumber = json['phoneNumber'] as String?,
      finCode = json['fin'] as String?;

  @override
  Map<String, dynamic> toJson() => {
    'name' : name,
    'surname' : surname,
    'phoneNumber' : phoneNumber,
    'fin' : finCode,
  };
}

// class UserDetailsModel {
//   final int? id;
//   final String? name;
//   final List<int>? photoBytes;
//   final String? about;

//   UserDetailsModel({
//     this.id,
//     this.name,
//     this.photoBytes,
//     this.about,
//   });

//   UserDetailsModel.fromJson(Map<String, dynamic> json)
//     : id = json['id'] as int?,
//       name = json['name'] as String?,
//       photoBytes = json['photoBytes'] as List<int>?,
//       about = json['about'] as String?;

//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'photoBytes' : photoBytes,
//     'about' : about
//   };
// }