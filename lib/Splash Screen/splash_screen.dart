import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Splash%20Screen/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.find<SplashController>();
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Todo App"),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.black87, strokeWidth: 2),
            SizedBox(height: 5),
            Text("Wait for 2 minutes"),
          ],
        ),
      ),
    );
  }
}
