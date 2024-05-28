part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class GetProfileSuccessfully extends ProfileState {
  final UserEntity profile;

  const GetProfileSuccessfully({required this.profile});

  @override
  List<Object> get props => [profile];
}

final class GetProfileUnSuccessfully extends ProfileState {
  final String message;

  const GetProfileUnSuccessfully({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetProfileLoading extends ProfileState {}
