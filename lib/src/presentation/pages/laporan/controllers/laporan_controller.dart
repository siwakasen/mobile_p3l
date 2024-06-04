import 'package:mobile_p3l/src/data/models/laporanPenggunaanBBModel.dart';
import 'package:mobile_p3l/src/data/models/laporanStokBB.dart';
import 'package:mobile_p3l/src/data/repositories/laporanRepository.dart';

class LaporanController {
  final LaporanRepository _laporanRepository = LaporanRepository();

  Future<List<LaporanPenggunaanBB>> getLaporanPenggunaanBB(
      String token, String from, String to) async {
    return _laporanRepository.getLaporanPenggunaanBB(token, from, to);
  }

  Future<List<LaporanBahanBaku>> getLaporanBahanBaku(String token) async {
    return _laporanRepository.getLaporanBahanBaku(token);
  }
}
