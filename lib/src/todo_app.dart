import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(421, 935),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Todo Application',
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          initialRoute: '/',
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
