import 'package:mobile_p3l/src/data/models/pesananModel.dart';
import 'package:mobile_p3l/src/data/repositories/orderOnProgressRepository.dart';

class OrderOnProgressController {
  final OrderOnProgressRepository _orderOnProgressRepository = OrderOnProgressRepository();

  Future<List<Pesanan>> getOrderOnProgress(String token) async {
    return _orderOnProgressRepository.getOrderOnProgress(token);
  }

  Future<void> updateOrderStatus(String token, int id, String status) async {
    return _orderOnProgressRepository.updatePesanan(token, id, status);
  }
}
