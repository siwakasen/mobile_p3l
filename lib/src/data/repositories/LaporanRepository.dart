// ignore_for_file: file_names
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/data/models/laporanPenggunaanBBModel.dart';
import 'package:dio/dio.dart';

class LaporanRepository {
  final Dio client = Dio();

  Future<List<LaporanPenggunaanBB>> getLaporanPenggunaanBB(String token, String from, String to) async {
    try {
      final res = await client.get(
        '$API_URL${ENDPOINT}administrator/laporan/penggunaan-bahan-baku/$from/$to',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        )
      );
      return (res.data['data'] as List).map((e) => LaporanPenggunaanBB.fromJson(e)).toList();
    } on DioException catch (e) {
      throw e.response!;
    } catch (e) {
      throw e.toString();
    }
  }
}