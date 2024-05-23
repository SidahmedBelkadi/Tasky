part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccessful extends SignUpState {
  final AuthResponseEntity authResponseEntity;

  const SignUpSuccessful({required this.authResponseEntity});

  @override
  List<Object> get props => [authResponseEntity];
}

final class SignUpUnSuccessful extends SignUpState {
  final String message;

  const SignUpUnSuccessful({required this.message});

  @override
  List<Object> get props => [message];
}

final class SignUpLoading extends SignUpState {}
