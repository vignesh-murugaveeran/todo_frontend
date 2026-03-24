import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/homeScreen.dart';
import 'package:todo_app/local_storage/local_storage.dart';
import 'package:todo_app/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  RxBool isLogin = true.obs;
  RxBool showPass = true.obs;

  RxString userEmail = ''.obs;

  Future signUp(
    context,
    String userName,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      final res = await _apiService.signUp(
        userName,
        phoneNumber,
        email,
        password,
      );
      print('response: $res');

      if (res['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.login, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('${res['message']}')),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
        );
        Get.to(() => Homescreen());
      } else if (res['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('${res['message']}')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      print("login error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text('Something went wrong')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
      );
    }
  }

  Future login(context, String email, String password) async {
    try {
      final res = await _apiService.login(email, password);
      print('response: $res');

      if (res['status'] == true) {
        final userEmail = res['data']['user']['email'];
        LocalStorage.sharedPreferences?.setString('email', userEmail);
        // LocalStorage.sharedPreferences?.setString(
        //   'email',
        //   userEmail,
        // );
        // Update reactive variable
        this.userEmail.value = userEmail;
        LocalStorage.sharedPreferences?.setString(
          'accesToken',
          res['data']['accessToken'],
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.login, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('${res['message']}')),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
        );
        Get.to(() => Homescreen());
      } else if (res['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('${res['message']}')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      print("login error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text('Something went wrong')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
      );
    }
  }
}
