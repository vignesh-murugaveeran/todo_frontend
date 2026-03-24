import 'package:get/get.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/homeScreen.dart';
import 'package:todo_app/local_storage/local_storage.dart';
import 'package:todo_app/routes/app_routes.dart';

class SplashController extends GetxController {
  final a = 10.obs;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(seconds: 2), () {
      String token =
          LocalStorage.sharedPreferences?.getString("accesToken") ?? "";
      print(token);
      if (token == null || token == "") {
        // Get.offAll(LoginScreen());
        Get.offAllNamed(Routes.login);
      } else {
        // Get.off(Homescreen());
        Get.offAllNamed(Routes.home);
      }
      // Get.off(
      // () => const BottomNavigationBarPage(),
      //() => const LoginPage(),
      // ); // Replaces the splash with MainPage
    });
  }
}
