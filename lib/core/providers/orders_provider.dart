
import 'package:get/get.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class OrdersProvider extends GetxController {
  final List<OrderItem> _orders = [];

  // get all orders
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    // add order in the first List
    _orders.insert(
        0,
        OrderItem(
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
          amount: total,
          products: cartItems,
        ));
    update();
  }
}
