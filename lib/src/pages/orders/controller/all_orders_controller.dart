import 'package:get/get.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  final _ordersRepository = OrdersRepository();
  final _authController = Get.find<AuthController>();
  final _utilServices = UtilsServices();

  List<OrderModel> allOrders = [];

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await _ordersRepository
        .getAllOrders(
          userId: _authController.user.id!,
          token: _authController.user.token!,
        );

    result.when(
      success: (orders) {
        allOrders = orders;
        update();
      },
      error: (message) {
        _utilServices.showToast(msg: message, isError: true);
      },
    );
  }
}
