import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> gatCartItems({
    required String token,
    required String userId,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {'user': userId},
    );

    if (response['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(
            response['result'],
          ).map(CartItemModel.fromJson).toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error(
        'Ocorreu um erro ao recuperar os itens do carrinho',
      );
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.changeItemQuantity,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {'cartItemId': cartItemId, 'quantity': quantity},
    );

    return response.isEmpty;
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {'user': userId, 'quantity': quantity, 'productId': productId},
    );

    if (response['result'] != null) {
      return CartResult.success(response['result']['id']);
    } else {
      return CartResult.error('Não foi possível adicionar item no carrinho');
    }
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {'total': total},
    );

    if (response['result'] != null) {
      final order = OrderModel.fromJson(response['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Não foi possível realizar o pedido');
    }
  }
}
