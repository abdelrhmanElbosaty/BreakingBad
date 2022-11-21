import 'package:breaking_bad_bloc/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(appRoute: AppRouter()));
}

class MyApp extends StatelessWidget {

  final AppRouter appRoute;

  const MyApp({super.key, required this.appRoute});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
    );
  }
}
