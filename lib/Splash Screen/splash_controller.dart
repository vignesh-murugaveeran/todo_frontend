import 'package:get/get.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/local_storage/local_storage.dart';

class SplashController extends GetxController {
  final a = 10.obs;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(seconds: 2), () {
      String token = LocalStorage.sharedPreferences?.getString("token") ?? "";
      print(token);
      if (token == null || token == "") {
        Get.offAll(LoginScreen());
      } else {
        // Get.off(BottomNavigationBarPage());
      }
      // Get.off(
      // () => const BottomNavigationBarPage(),
      //() => const LoginPage(),
      // ); // Replaces the splash with MainPage
    });
  }
}
