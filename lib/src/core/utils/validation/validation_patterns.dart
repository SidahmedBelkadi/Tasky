class ValidationPatterns {
  static const String namePattern = r'^.{5,100}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';
  static const String passwordPattern = r'^.{6,100}$';
  static const String emailPattern = r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
  static const String addressPattern = r'^.{5,200}$';
  static const String yearsOfExperiencePattern = r'^\d+$';
}
