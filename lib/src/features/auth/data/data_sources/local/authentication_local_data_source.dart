import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/resources/app.keys.dart';
import '../../models/auth_response_model.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveLoginCredentials({required AuthResponseModel authResponse});
  AuthResponseModel? getSavedLoginCredentials();
  Future<void> clearLoginCredentials();
}

class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> clearLoginCredentials() async {
    await sharedPreferences.remove(AppKeys.userID);
    await sharedPreferences.remove(AppKeys.userName);
    await sharedPreferences.remove(AppKeys.accessToken);
    await sharedPreferences.remove(AppKeys.refreshToken);
  }

  @override
  AuthResponseModel? getSavedLoginCredentials() {
    final String? userId = sharedPreferences.getString(AppKeys.userID);
    final String? userName = sharedPreferences.getString(AppKeys.userName);
    final String? accessToken = sharedPreferences.getString(AppKeys.accessToken);
    final String? refreshToken = sharedPreferences.getString(AppKeys.refreshToken);

    if (userId != null && userName != null && accessToken != null && refreshToken != null) {
      return AuthResponseModel(
        userId: userId,
        name: userName,
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }
    return null;
  }

  @override
  Future<void> saveLoginCredentials({required AuthResponseModel authResponse}) async {
    await sharedPreferences.setString(AppKeys.userID, authResponse.userId);
    await sharedPreferences.setString(AppKeys.userName, authResponse.name);
    await sharedPreferences.setString(AppKeys.accessToken, authResponse.accessToken);
    await sharedPreferences.setString(AppKeys.refreshToken, authResponse.refreshToken);
  }
}
