import "package:mobile_p3l/src/data/models/historiSaldoModel.dart";
import 'package:mobile_p3l/src/data/repositories/historiSaldoRepository.dart';


class HistoriSaldoController {
  final HistoriSaldoRepository _historiSaldoRepository = HistoriSaldoRepository();

  Future<List<HistoriSaldo>> getHistoriSaldo(String token) async {
    return _historiSaldoRepository.getHistoriSaldo(token);
  }

  Future addHistoriSaldo(String token, int nominal) async {
    return _historiSaldoRepository.addHistoriSaldo(token, nominal);
  }

  Future getSaldo(String token) async {
    return _historiSaldoRepository.getSaldo(token);
  }
}
