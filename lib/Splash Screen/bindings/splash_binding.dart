import 'package:get/get.dart';
import 'package:todo_app/Splash%20Screen/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
