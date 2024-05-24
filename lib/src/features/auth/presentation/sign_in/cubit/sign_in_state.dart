part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInSuccessful extends SignInState {
  final AuthResponseEntity authResponseEntity;

  const SignInSuccessful({required this.authResponseEntity});

  @override
  List<Object> get props => [authResponseEntity];
}

final class SignInUnSuccessful extends SignInState {
  final String message;

  const SignInUnSuccessful({required this.message});

  @override
  List<Object> get props => [message];
}

final class SignInLoading extends SignInState {}
