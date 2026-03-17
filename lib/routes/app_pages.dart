import 'package:get/get.dart';
import 'package:todo_app/authentication/bindings/home_bindings.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),

    // GetPage(
    //   name: Routes.product,
    //   page: () => ProductScreen(),
    //   binding: ProductBindings(),
    // ),
  ];
}
