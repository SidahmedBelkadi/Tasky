import '../../../config/routes/app_routes.dart';
import '../../../features/auth/data/data_sources/local/authentication_local_data_source.dart';
import '../../../features/auth/data/models/auth_response_model.dart';
import 'launch_helper.dart';

class InitialRouteHelper {
  final LaunchHelper launchHelper;
  final AuthenticationLocalDataSource authLocalDataSource;

  InitialRouteHelper({
    required this.launchHelper,
    required this.authLocalDataSource,
  });

  String determineInitialRoute() {
    final bool isFirstTime = launchHelper.isFirstTime();
    final AuthResponseModel? authResponse = authLocalDataSource.getSavedLoginCredentials();

    if (isFirstTime) {
      return Routes.onBoarding;
    } else if (authResponse != null && authResponse.accessToken.isNotEmpty) {
      return Routes.tasksHome;
    } else {
      return Routes.signIn;
    }
  }
}
