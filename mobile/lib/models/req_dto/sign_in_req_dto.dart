class SignInReqDTO {
  final String fin;
  final String password;

  SignInReqDTO({
    required this.fin,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'fin' : fin,
    'password' : password
  };
}