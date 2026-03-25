import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
          LocalStorage.sharedPreferences?.getString("accessToken") ?? "";
      print(token);
      if (token.isEmpty) {
        // Get.offAll(LoginScreen());
        Get.offAllNamed(Routes.login);
        return;
      }
      ///WITHOUT REFRESH TOKEN
      else {
        // Get.off(Homescreen());
        Get.offAllNamed(Routes.home);
      }

      ///WITH REFRESH TOKEN
      // bool isExpired = JwtDecoder.isExpired(token);

      // if (isExpired) {
      //   Get.offAllNamed(Routes.login);
      // } else {
      //   Get.offAllNamed(Routes.home);
      // }
    });
  }
}
