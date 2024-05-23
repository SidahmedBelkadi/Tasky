import '../enums/input_type_enum.dart';
import 'validation_messages.dart';
import 'validation_patterns.dart';

class Validator {
  Validator._();

  static String? validate({
    required String value,
    required InputType type,
    bool isRequired = true,
  }) {
    if (isRequired && value.isEmpty) {
      return ValidationErrorMessages.requiredError;
    }

    if (value.isNotEmpty) {
      switch (type) {
        case InputType.name:
          if (!RegExp(ValidationPatterns.namePattern).hasMatch(value)) {
            return ValidationErrorMessages.nameError;
          }
          break;
        case InputType.phone:
          if (!RegExp(ValidationPatterns.phonePattern).hasMatch(value)) {
            return ValidationErrorMessages.phoneError;
          }
          break;
        case InputType.password:
          if (!RegExp(ValidationPatterns.passwordPattern).hasMatch(value)) {
            return ValidationErrorMessages.passwordError;
          }
          break;
        case InputType.email:
          if (!RegExp(ValidationPatterns.emailPattern).hasMatch(value)) {
            return ValidationErrorMessages.emailError;
          }
          break;
        case InputType.address:
          if (!RegExp(ValidationPatterns.addressPattern).hasMatch(value)) {
            return ValidationErrorMessages.addressError;
          }
          break;
        case InputType.yearsOfExperience:
          if (!RegExp(ValidationPatterns.yearsOfExperiencePattern).hasMatch(value)) {
            return ValidationErrorMessages.yearsOfExperienceError;
          }
          break;
        default:
          return null;
      }
    }
    return null;
  }
}
