import 'package:get/get.dart';
import 'package:todo_app/authentication/controller/auth_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
