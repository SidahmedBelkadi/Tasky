class SignUpParams {
  final String name;
  final String phoneNumber;
  final String experienceLevel;
  final String yearsOfExperience;
  final String address;
  final String password;

  SignUpParams({
    required this.name,
    required this.phoneNumber,
    required this.experienceLevel,
    required this.yearsOfExperience,
    required this.address,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'displayName': name,
      'phone': phoneNumber,
      'level': experienceLevel,
      'experienceYears': yearsOfExperience,
      'address': address,
      'password': password,
    };
  }
}
