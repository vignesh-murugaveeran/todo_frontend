import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Splash%20Screen/splash_screen.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/routes/app_pages.dart';
import 'package:todo_app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      getPages: AppPages.routes,
      title: 'Folder Structure',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const LoginScreen(),
    );
  }
}
