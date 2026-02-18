import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {'user': userId},
    );

    if (response['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(
            response['result'],
          ).map(OrderModel.fromJson).toList();
      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não foi possível recuperar os pedidos');
    }
  }

  Future<OrdersResult<List<CartItemModel>>> getOrderItems({
    required String token,
    required String orderId,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {'orderId': orderId},
    );

    if (response['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(
            response['result'],
          ).map(CartItemModel.fromJson).toList();

      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.error(
        'Não foi possível recuperar os produtos do pedido',
      );
    }
  }
}
