// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_store_app/view/screens/cart_screen.dart';
import '../../core/providers/cart_provider.dart';
import '../widgets/products_grid.dart';
class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  //var _showFavouriteOnly = false;
  CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          Obx(
            () {
              return Badge(
                label: Text(controller.itemsCount.value.toString()),
                textColor: Colors.orange,
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.grey[600]),
                  onPressed: () {
                    Get.to(()=>CartScreen());
                  },
                ),
              );
            }),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
