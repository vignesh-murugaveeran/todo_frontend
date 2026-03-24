import 'package:get/get.dart';
import 'package:todo_app/Splash%20Screen/bindings/splash_binding.dart';
import 'package:todo_app/Splash%20Screen/splash_screen.dart';
import 'package:todo_app/authentication/bindings/login_bindings.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/homeScreen.dart';
import 'package:todo_app/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.home,
      page: () => Homescreen(),
      binding: LoginBindings(),
    ),

    // GetPage(
    //   name: Routes.product,
    //   page: () => ProductScreen(),
    //   binding: ProductBindings(),
    // ),
  ];
}
