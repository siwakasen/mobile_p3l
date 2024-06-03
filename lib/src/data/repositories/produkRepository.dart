import "package:dio/dio.dart";
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/data/models/produkEntity.dart';

class ProdukRepository {
  final Dio client = Dio();

  Future<List<Produk>?> getProduk() async {
    try {
      final res = await client.get(
        '$API_URL${ENDPOINT}administrator/produk',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (res.statusCode == 200) {
        List data = res.data['data'] as List;
        List<Produk> test = data
            .map((e) => Produk.fromJson(e as Map<String, dynamic>))
            .toList();
        return test;
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      // handle Dio-specific exceptions
      throw e.response != null ? e.response!.data : e.message;
    } catch (e) {
      // handle other exceptions
      throw e.toString();
    }
  }

  Future<List<Produk>>? searchProduk(query) async{
    try {
      final res = await client.get(
        '$API_URL${ENDPOINT}administrator/produk/search?query=$query',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (res.statusCode == 200) {
        List data = res.data['data'] as List;
        List<Produk> test = data
            .map((e) => Produk.fromJson(e as Map<String, dynamic>))
            .toList();
        return test;
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      // handle Dio-specific exceptions
      throw e.response != null ? e.response!.data : e.message;
    } catch (e) {
      // handle other exceptions
      throw e.toString();
    }
  }
}
