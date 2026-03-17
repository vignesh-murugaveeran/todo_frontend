import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  // final String baseUrl = 'http://localhost:3000';
  final String baseUrl = 'http://10.0.2.2:3000';
  // final String baseUrl = 'http://172.16.45.11:3000';

  Future login(String email, String password) async {
    try {
      final res = await Dio().post(
        '$baseUrl/api/users/register',
        data: {'email': email, 'password': password},
        options: Options(
          validateStatus: (status) => true, // prevents crash
        ),
      );

      if (res.statusCode == 201) {
        return res.data;
      }

      return res.data;
    } on DioException catch (err) {
      // final errData = err.response?.data;

      // if (errData != null && errData is Map<String, dynamic>) {
      //   return errData;
      // }

      // return {'status': false, 'message': err.message ?? 'Some Went Wrong!'};
      throw Exception('Failed error....: $err');
    }
  }
}
