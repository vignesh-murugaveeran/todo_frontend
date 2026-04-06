import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/authentication/controller/auth_controller.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/bottom_nav_bar1.dart';
import 'package:todo_app/bottom_nav_bar2.dart';
import 'package:todo_app/local_storage/local_storage.dart';
import 'package:todo_app/poppups/poppups.dart';
import 'package:todo_app/routes/app_routes.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final AuthController _authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEmail();
    _authController.getProfile();
  }

  void loadEmail() {
    _authController.userEmail.value =
        LocalStorage.sharedPreferences?.getString('email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  'Hello ${_authController.userEmail.value.isEmpty ? 'No Email Id' : _authController.userEmail.value}',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Get.offAll(() => LoginScreen());
                  showCallAlertDialog(
                    context,
                    'Logout!',
                    'Are you sure want to logout?',
                    () async {
                      // await DioApi().logout();
                      await LocalStorage.sharedPreferences?.clear();
                      await Get.offAllNamed(Routes.login);
                    },
                    Colors.red,
                  );
                },
                label: const Text('Logout'),
                icon: Icon(Icons.logout),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => DemoApp());
                },
                label: const Text('Go-1'),
                icon: Icon(Icons.arrow_forward),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => RmsApp());
                },
                label: const Text('Go-2'),
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
