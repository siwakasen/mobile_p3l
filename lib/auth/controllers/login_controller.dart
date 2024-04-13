import 'package:dio/dio.dart';
import 'package:mobile_p3l/constants.dart';

class LoginController {
  Future login(String email, String password) async {
    try {
      final res = await client.post(
        '$API_URL${ENDPONT}auth/login',
        options: options,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (res.data['data']['role'] == 'Manajer Operasional') {
        setPreference('role', res.data['data']['role']);
        return res;
      }

      if (res.data['data']['role'] == null) {
        setPreference('role', 'User');
        return res;
      }

      res.statusCode = 401;
      res.data['message'] = 'Anda tidak memiliki akses';
      return res;
    } on DioException catch (e) {
      return e.response!;
    } catch (e) {
      throw e.toString();
    }
  }
}
