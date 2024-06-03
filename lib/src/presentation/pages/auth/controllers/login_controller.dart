import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobile_p3l/src/utils/constants.dart';

class LoginController {
  Future login(String email, String password) async {
    try {
      final res = await client.post(
        '$API_URL${ENDPOINT}auth/login',
        options: options,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (res.data['data']['role'] == 'Manajer Operasional') {
        setPreference('id', res.data['data']['id_karyawan'].toString());
        setPreference('nama', res.data['data']['nama_karyawan']);
        setPreference('email', res.data['data']['email']);
        setPreference('role', res.data['data']['role']);
        setPreference('token', res.data['token']);
        return res;
      }
      if (res.data['data']['role'] == 'User') {
        FirebaseMessaging.instance.subscribeToTopic('all');
        var token = await FirebaseMessaging.instance.getToken();
        await client.post(
          '$API_URL${ENDPOINT}auth/storeNotifTokens',
          options: options,
          data: {
            'token': token,
            'id_user': res.data['data']['id'].toString(),
          },
        );

        setPreference('id', res.data['data']['id'].toString());
        setPreference('nama', res.data['data']['name']);
        setPreference('email', res.data['data']['email']);
        setPreference('tanggal_lahir', res.data['data']['tanggal_lahir']);
        setPreference('no_hp', res.data['data']['no_hp']);
        setPreference('saldo', res.data['data']['saldo'].toString());
        setPreference('poin', res.data['data']['poin'].toString());
        setPreference('role', res.data['data']['role']);
        setPreference('token', res.data['token']);
        return res;
      }
      res.statusCode = 400;
      res.data['message'] = 'Unathorized access';
      return res;
    } on DioException catch (e) {
      return e.response!;
    } catch (e) {
      throw e.toString();
    }
  }
}
