import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'src/bloc_observer.dart';
import 'src/injection_container.dart' as di;
import 'src/todo_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // ============= Initiallize Service Locator for Dependency Injection
  await di.initializeAppDependencies();

  // ============= Register Bloc Observer
  Bloc.observer = AppObserver();

  FlutterNativeSplash.remove();
  runApp(const TodoApp());
}
