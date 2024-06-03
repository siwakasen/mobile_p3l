// ignore_for_file: file_names
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:mobile_p3l/src/data/models/presensiModel.dart';

class PresensiRepository{
  final Dio client = Dio();

  Future<List<Presensi>> getPresensi(String token, String tanggal) async {
    try {
      final res = await client.get(
        '$API_URL${ENDPOINT}administrator/presensi/$tanggal',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return (res.data['data'] as List).map((e) => Presensi.fromJson(e)).toList();
    } on DioException {
      return [];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> generatePresensi(String token, String tanggal) async {
    try {
      await client.post(
        '$API_URL${ENDPOINT}administrator/presensi',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'tanggal': tanggal,
        },
      );
    } on DioException catch (e) {
      throw e.response!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updatePresensi(String token, int id, String status) async {
    try {
      await client.put(
        '$API_URL${ENDPOINT}administrator/presensi/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'status': status,
        },
      );
    } on DioException catch (e) {
      throw e.response!;
    } catch (e) {
      throw e.toString();
    }
  }
}
    