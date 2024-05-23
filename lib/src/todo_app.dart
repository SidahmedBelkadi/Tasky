import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../src/injection_container.dart' as di;
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/helpers/launch_helper.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isFirstTime = di.serviceLocator<LaunchHelper>().isFirstTime();

    return ScreenUtilInit(
      designSize: const Size(421, 935),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Todo Application',
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          initialRoute: isFirstTime ? Routes.initialRoute : Routes.signIn,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
