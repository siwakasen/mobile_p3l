import "package:dio/dio.dart";
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/data/models/hampersEntity.dart';

class HampersRepository {
  final Dio client = Dio();

  Future<List<Hampers>?> getHampers() async {
    try {
      final res = await client.get(
        '$API_URL${ENDPOINT}administrator/hampers',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (res.statusCode == 200) {
        List data = res.data['data'] as List;
        List<Hampers> test = data
            .map((e) => Hampers.fromJson(e as Map<String, dynamic>))
            .toList();

        // print(test);
        return test;
      } else {
        throw Exception('Failed to load hampers');
      }
    } on DioException catch (e) {
      // handle Dio-specific exceptions
      throw e.response != null ? e.response!.data : e.message;
    } catch (e) {
      // handle other exceptions
      throw e.toString();
    }
  }

  Future<List<Hampers>>? searchHampers(query, date) async {
    try {
      final res = await client.get(
        '$API_URL${ENDPOINT}administrator/hampers/search?query=$query&date=$date',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (res.statusCode == 200) {
        List data = res.data['data'] as List;
        List<Hampers> test = data
            .map((e) => Hampers.fromJson(e as Map<String, dynamic>))
            .toList();
        return test;
      } else {
        throw Exception('Failed to load hampers');
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
