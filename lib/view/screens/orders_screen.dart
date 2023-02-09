
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/providers/orders_provider.dart';
import '../widgets/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  final OrdersProvider controller = Get.put(OrdersProvider());
   OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: controller.orders.length,
        itemBuilder: (ctx, i) => OrderItemWidget(controller.orders[i]),
      ),
    );
  }
}
