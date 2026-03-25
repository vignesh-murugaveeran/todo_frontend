import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:todo_app/access_storage/access_storage.dart';
import 'package:todo_app/authentication/loginScreen.dart';
import 'package:todo_app/constansts/baseUrl.dart';
import 'package:todo_app/local_storage/local_storage.dart';
import 'package:todo_app/poppups/poppups.dart';

class DioUtil {
  static late Dio dio;

  ///WITH REFRESH TOKEN
  static bool isRefreshing = false;
  static List<RequestOptions> pendingRequests = [];

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
                  "accessToken",
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
              LocalStorage.sharedPreferences?.remove('accessToken');
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

          ///WITHOUT REFRESH TOKEN
          // onError: (error, req) {
          //   if (error.response?.statusCode == 401) {
          //     LocalStorage.sharedPreferences?.remove('accessToken');
          //     Get.offAll(LoginScreen());
          //   }
          //   errorPopup(
          //     AccessStorageController.navigatorKey.currentContext!,
          //     error.toString(),
          //   );
          //   req.next(error);
          // },

          ///WITH REFRESH TOKEN
          onError: (DioException error, handler) async {
            // ONLY handle 401 here
            if (error.response?.statusCode == 401) {
              final refreshToken = LocalStorage.sharedPreferences?.getString(
                "refreshToken",
              );

              // No refresh token → logout
              if (refreshToken == null) {
                _logout();
                return handler.next(error);
              }

              try {
                //  If already refreshing → queue requests
                if (isRefreshing) {
                  pendingRequests.add(error.requestOptions);
                  return;
                }

                isRefreshing = true;

                // Call refresh API
                final response = await dio.post(
                  '$baseUrl/refresh',
                  data: {"refreshToken": refreshToken},
                );

                final newAccessToken = response.data['accessToken'];

                // Save new token
                await LocalStorage.sharedPreferences?.setString(
                  "accessToken",
                  newAccessToken,
                );

                // Retry original request

                ///WITHOUT TOKEN
                // final opts = error.requestOptions;
                // opts.headers['Authorization'] = "Bearer $newAccessToken";
                // final cloneReq = await dio.fetch(opts);

                ///WITH TOKEN
                final opts = error.requestOptions;

                final newOptions = Options(
                  method: opts.method,
                  headers: {
                    ...opts.headers,
                    'Authorization': 'Bearer $newAccessToken',
                  },
                );

                final cloneReq = await dio.request(
                  opts.path,
                  options: newOptions,
                  data: opts.data,
                  queryParameters: opts.queryParameters,
                );

                // Retry all pending requests
                for (var request in pendingRequests) {
                  request.headers['Authorization'] = "Bearer $newAccessToken";
                  dio.fetch(request);
                }

                pendingRequests.clear();

                isRefreshing = false;

                return handler.resolve(cloneReq);
              } catch (e) {
                isRefreshing = false;

                // Refresh failed → logout
                _logout();
                return handler.next(error);
              }
            }

            // Other errors
            errorPopup(
              AccessStorageController.navigatorKey.currentContext!,
              error.toString(),
            );

            return handler.next(error);
          },
        ),
      );
  }

  static void _logout() {
    isRefreshing = false;
    pendingRequests.clear();

    LocalStorage.sharedPreferences?.remove('accessToken');
    LocalStorage.sharedPreferences?.remove('refreshToken');

    Get.offAll(LoginScreen());
  }
}
