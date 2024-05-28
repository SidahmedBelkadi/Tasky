import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/src/core/utils/helpers/toast_helper.dart';
import 'package:tasky/src/core/utils/resources/app_messages.dart';
import 'package:tasky/src/features/profile/domain/entities/user_entity.dart';
import 'package:tasky/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tasky/src/features/profile/presentation/widgets/profile_skeleton.dart';

import '../../../core/common/widgets/app_bar.dart';
import '../../../core/common/widgets/app_text_form_field.dart';
import '../../../core/utils/resources/app_icons.dart';
import '../../../core/utils/resources/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTasksAppBar(
        title: AppStrings.profile,
        showLeading: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is GetProfileUnSuccessfully) {
            AppToasts.showErrorToast(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is GetProfileLoading) {
            return const ProfileSkeleton();
          }

          if (state is GetProfileUnSuccessfully) {
            return Center(
              child: Text(
                AppMessages.errorDuringCommunication,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state is GetProfileSuccessfully) {
            final UserEntity profile = state.profile;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 22.w),
                child: Column(
                  children: [
                    /// Name
                    AppTextFormField(
                      readOnly: true,
                      filled: true,
                      label: AppStrings.nameMaj,
                      isBold: true,
                      textEditingController: TextEditingController.fromValue(
                        TextEditingValue(text: profile.name),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// Phone
                    AppTextFormField(
                      readOnly: true,
                      filled: true,
                      label: AppStrings.phone,
                      suffixIcon: AppIcons.copy,
                      onSuffixTap: () {
                        Clipboard.setData(ClipboardData(text: profile.phoneNumber));
                        AppToasts.showInfoToast(message: "Phone number copied", context: context);
                      },
                      isBold: true,
                      textEditingController: TextEditingController.fromValue(
                        TextEditingValue(text: profile.phoneNumber),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// Level
                    AppTextFormField(
                      readOnly: true,
                      filled: true,
                      label: AppStrings.level,
                      isBold: true,
                      textEditingController: TextEditingController.fromValue(
                        TextEditingValue(text: profile.level),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// Years of exp
                    AppTextFormField(
                      readOnly: true,
                      filled: true,
                      label: AppStrings.yearsOfExpMaj,
                      isBold: true,
                      textEditingController: TextEditingController.fromValue(
                        TextEditingValue(text: "${profile.experience} Years"),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// Location
                    AppTextFormField(
                      readOnly: true,
                      filled: true,
                      label: AppStrings.location,
                      isBold: true,
                      textEditingController: TextEditingController.fromValue(
                        TextEditingValue(text: profile.address),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
