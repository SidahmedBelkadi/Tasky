import '../../domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({
    required super.userId,
    super.name,
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      userId: json['_id'],
      name: json['displayName'] as String?,
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'displayName': name,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
