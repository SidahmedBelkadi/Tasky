import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_input/phone_input_package.dart';
import '../../widgets/password_field.dart';
import '../../widgets/phone_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          PhoneField(
            phoneController: PhoneController(const PhoneNumber(isoCode: IsoCode.EG, nsn: '')),
          ),
          SizedBox(height: 12.h),
          PasswordField(
            isObsecure: true,
            toggleVisibility: () {},
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
