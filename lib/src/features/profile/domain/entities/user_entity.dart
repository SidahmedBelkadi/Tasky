import 'package:equatable/equatable.dart';
import 'package:libphonenumber/libphonenumber.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String phoneNumber;
  final String level;
  final int experience;
  final String address;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.level,
    required this.experience,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, level, experience, address];

  // Method to format the phone number
  Future<String> getFormattedPhoneNumber({String defaultRegion = 'US'}) async {
    try {
      final isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: phoneNumber,
        isoCode: defaultRegion,
      );
      if (isValid ?? false) {
        final formattedNumber = await PhoneNumberUtil.normalizePhoneNumber(
          phoneNumber: phoneNumber,
          isoCode: defaultRegion,
        );
        return formattedNumber ?? phoneNumber;
      } else {
        return phoneNumber; // Return as is if the number is invalid
      }
    } catch (e) {
      return phoneNumber; // Return as is in case of any exception
    }
  }
}
