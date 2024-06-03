// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:mobile_p3l/src/utils/constants.dart';

class ChangePasswordController {
  Future sendRequest(String email) async {
    try {
      final res = await client.post(
        '$API_URL${ENDPOINT}customer/reset-password/create-token',
        options: options,
        data: {
          'email': email,
        },
      );

      return res;
    } on DioException catch (e) {
      return e.response!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future changePassword(
      String password, String confirm_password, String email) async {
    try {
      final res = await client.post(
        '$API_URL${ENDPOINT}customer/reset-password/submit-reset',
        options: options,
        data: {
          'email': email,
          'password': password,
          'confirm_password': confirm_password,
        },
      );
      return res;
    } on DioException catch (e) {
      return e.response!;
    } catch (e) {
      throw e.toString();
    }
  }
}
