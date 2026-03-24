import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/authentication/dio_util.dart';
import 'package:todo_app/local_storage/local_storage.dart';
import 'package:todo_app/routes/app_pages.dart';
import 'package:todo_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioUtil.init();
  LocalStorage.sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
      title: 'Folder Structure',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),

      ///When you use home, GetX bindings DO NOT run
      // home: const SplashScreen(),
    );
  }
}

/*
Method	             Behavior
Get.put()	       Creates immediately
Get.lazyPut()  	Creates only when needed
*/
