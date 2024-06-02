import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:mobile_p3l/src/data/models/historiSaldoModel.dart';

class HistoriSaldoRepository {
  final Dio client = Dio();

  Future<List<HistoriSaldo>> getHistoriSaldo(String token) async {
    try {
      final res = await client.get('$API_URL${ENDPONT}customer/penarikan-saldo',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      return (res.data['data'] as List)
          .map((e) => HistoriSaldo.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw e.response!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future addHistoriSaldo(
      String token, int nominal) async {
    try {
      final res = await client.post('$API_URL${ENDPONT}customer/penarikan-saldo',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            'nominal_saldo': nominal,
          });
      return res;
    } on DioException catch (e) {
      throw e.response!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future getSaldo(String token) async {
    try {
      final res = await client.get('$API_URL${ENDPONT}customer/saldo',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      return res.data['data'];
    } on DioException catch (e) {
      throw e.response!;
    } catch (e) {
      throw e.toString();
    }
  }

  

}
