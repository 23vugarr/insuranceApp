class SignUpReqDTO {
  final String fin;
  final String phoneNumber;
  final String password;

  SignUpReqDTO({
    required this.fin,
    required this.phoneNumber,
    required this.password,
  });
  
  Map<String, dynamic> toJson() => {
    'fin' : fin,
    'phoneNumber' : phoneNumber,
    'password' : password
  };
}