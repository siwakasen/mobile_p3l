// ignore_for_file: file_names
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/data/models/pesananModel.dart';
import 'package:dio/dio.dart';

class OrderHistoryRepository {
  final Dio client = Dio();

  Future<List<Pesanan>> getOrderHistory(String token) async {
    try {
      final res = await client.get(
        '$API_URL${ENDPOINT}customer/history',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        )
      );
      return (res.data['data'] as List).map((e) => Pesanan.fromJson(e)).toList();
    } on DioException catch (e) {
      throw e.response!;
    } catch (e) {
      throw e.toString();
    }
  }
}