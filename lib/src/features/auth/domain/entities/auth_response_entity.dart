import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  final String userId;
  final String name;
  final String accessToken;
  final String refreshToken;

  const AuthResponseEntity({
    required this.userId,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [userId, name, accessToken, refreshToken];
}
