
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_store_app/core/providers/product_model_provider.dart';
import 'package:phone_store_app/view/screens/cart_screen.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/products_provider.dart';
import '../widgets/product_details_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel index;
  final ProductsController controller = Get.put(ProductsController());
  final CartController cartController = Get.put(CartController());
   ProductDetailsScreen({super.key, required this.index});
  @override
  Widget build(BuildContext context) {

    // Listen to specific object
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(index.title!,
              style: const TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
          actions: [
            Obx(
               ( ) {
                return Badge(
                  label: Text(cartController.itemsCount.value.toString()),
                  // child: ch,
                  textColor: Colors.orange,

              child: IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.grey[600]),
                onPressed: () {
                  Get.to(()=> CartScreen());
                 // Navigator.pushNamed(context, cartScreenRoute);
                },
              ),
                );
              },
            ),

          IconButton(
                  icon: index.isFavorite!
                      ? const Icon(Icons.favorite, color: Color(0xFFEF7532))
                      : Icon(Icons.favorite_border, color: Colors.grey[600]),
                  color: Theme.of(context).accentColor,
                  onPressed:()=> controller.change(index.id!),
                )


          ],
        ),
        body: ProductDetailsWidget(product: index, index: index.id),
    );
}
}