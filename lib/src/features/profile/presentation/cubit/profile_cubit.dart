import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/src/features/profile/domain/entities/user_entity.dart';
import 'package:tasky/src/features/profile/domain/use_cases/profile_use_case.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase useCase;
  ProfileCubit({required this.useCase}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoading());

    final failureOrProfile = await useCase();

    failureOrProfile.fold(
      (failure) => emit(GetProfileUnSuccessfully(message: failure.message)),
      (profile) => emit(GetProfileSuccessfully(profile: profile)),
    );
  }
}
