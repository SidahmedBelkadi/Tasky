class SignInParams {
  final String phoneNumber;
  final String password;

  SignInParams({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phoneNumber,
      'password': password,
    };
  }
}
