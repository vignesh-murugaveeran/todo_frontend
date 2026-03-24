import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:todo_app/access_storage/access_storage.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/local_storage/local_storage.dart';
import 'package:todo_app/poppups/poppups.dart';

class DioUtil {
  static late Dio dio;

  static Future init() async {
    dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest:
              (
                RequestOptions requestOptions,
                RequestInterceptorHandler requestInterceptorHandler,
              ) async {
                if (requestOptions.uri.toString().contains(
                  'customer/contacts',
                )) {
                } else {
                  // EasyLoading.show();
                }

                var token = LocalStorage.sharedPreferences!.getString(
                  "accesToken",
                );

                if (token != null) {
                  requestOptions.headers['Authorization'] = "Bearer $token";
                }
                requestInterceptorHandler.next(requestOptions);
              },
          onResponse: (e, handler) {
            // if (EasyLoading.isShow) {
            //   if (!e.requestOptions.uri.toString().contains(
            //         'transaction_id',
            //       )) {
            //     EasyLoading.dismiss();
            //   }
            // }

            if (e.statusCode == 401) {
              LocalStorage.sharedPreferences?.remove('accesToken');
              Get.offAll(LoginScreen());
            }

            if (e.statusCode != 200 && e.statusCode != 201) {
              if (e.statusCode == 500) {
                errorPopup(
                  AccessStorageController.navigatorKey.currentContext!,
                  'Server Error!!',
                );
              } else {
                errorPopup(
                  AccessStorageController.navigatorKey.currentContext!,
                  e.data['detail'],
                );
              }
            }

            handler.next(e);
          },
          onError: (error, req) {
            if (error.response?.statusCode == 401) {
              LocalStorage.sharedPreferences?.remove('accesToken');
              Get.offAll(LoginScreen());
            }
            errorPopup(
              AccessStorageController.navigatorKey.currentContext!,
              error.toString(),
            );
            req.next(error);
          },
        ),
      );
  }
}
