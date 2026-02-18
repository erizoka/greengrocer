import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/orders/controller/all_orders_controller.dart';
import 'package:greengrocer/src/pages/orders/view/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos')),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return controller.allOrders.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.label_off,
                    size: 40,
                    color: CustomColors.customSwatchColor,
                  ),
                  const Text(
                    'Ainda não foi feito nenhum pedido',
                    textAlign: TextAlign.center,
                  ),
                ],
              )
              : ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, i) => const SizedBox(height: 10),
                itemCount: controller.allOrders.length,
                itemBuilder:
                    (_, i) => OrderTile(order: controller.allOrders[i]),
              );
        },
      ),
    );
  }
}
