
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_store_app/core/Firebase/firebase_db.dart';
import 'package:phone_store_app/core/models/order_item.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/orders_provider.dart';
import '../widgets/cart_item_widget.dart';
import 'Login/phone_screen.dart';
import 'orders_screen.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  final OrdersProvider orderController= Get.put(OrdersProvider());
  final getStorage = GetStorage();
   CartScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${controller.totalPriceAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleMedium!.color,
                      ),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  ElevatedButton(
                    child: const Text('ORDER NOW'),
                    onPressed: () {
                       FirebaseDb();
                     var isLogin = getStorage.read("isLogin");
                      if(isLogin){
                        orderController.addOrder(controller.cartItems.values.toList(),controller.totalPriceAmount);
                        FirebaseDb.addOrder(orderController.orders.last);
                        Get.to(()=> OrdersScreen());
                      }else if(isLogin == false || isLogin == null){
                        Get.to(()=> Login());
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (ctx, i) => CartItemWidget(
                itemId: controller.cartItems.keys.toList()[i], // CartItem id
                productId: controller.cartItems.values.toList()[i].id!,
                price: controller.cartItems.values.toList()[i].price!,
                quantity: controller.cartItems.values.toList()[i].quantity!,
                title: controller.cartItems.values.toList()[i].title!,
                // imageUrl: cart.cartItems.values.toList()[i].imageUrl!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
