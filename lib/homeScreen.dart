import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/local_storage/local_storage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String getEmailString() {
    return LocalStorage.sharedPreferences?.getString('email') ?? 'no email Id';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello ${getEmailString()}'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Get.offAll(() => LoginScreen());
                },
                label: const Text('Logout'),
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
