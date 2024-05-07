import 'package:mobile_p3l/data/models/presensiModel.dart';
import 'package:mobile_p3l/data/repositories/presensiRepository.dart';

class PresensiController {
  final PresensiRepository _presensiRepository = PresensiRepository();

  Future<List<Presensi>> getPresensi(String token, String tanggal) async {
    return _presensiRepository.getPresensi(token, tanggal);
  }

  Future<void> generatePresensi(String token, String tanggal) async {
    return _presensiRepository.generatePresensi(token, tanggal);
  }

  Future<void> updatePresensi(String token, int id, String status) async {
    return _presensiRepository.updatePresensi(token, id, status);
  }
}