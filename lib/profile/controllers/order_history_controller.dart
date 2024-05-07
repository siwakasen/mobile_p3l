import 'package:mobile_p3l/data/models/pesananModel.dart';
import 'package:mobile_p3l/data/repositories/OrderHistoryRepository.dart';

class OrderHistoryController {
  final OrderHistoryRepository _orderHistoryRepository = OrderHistoryRepository();

  Future<List<Pesanan>> getOrderHistory(String token) async {
    return _orderHistoryRepository.getOrderHistory(token);
  }
}