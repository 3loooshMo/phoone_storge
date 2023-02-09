// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/providers/cart_provider.dart';
import '../../core/providers/product_model_provider.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductModel product;
  final int? index;

   ProductDetailsWidget({super.key, required this.product, this.index});
   CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const SizedBox(height: 15.0),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(product.title.toString(),
            style: const TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      const SizedBox(height: 15.0),
      Hero(
          tag: 'tage$index',
          child: Image.network(product.imageUrl.toString(),
              height: 150.0, width: 100.0, fit: BoxFit.contain)),
      const SizedBox(height: 20.0),
      Center(
        child: Text(product.price.toString().toString(),
            style: const TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      const SizedBox(height: 10.0),
      Center(
        child: Text(product.title.toString(),
            style: const TextStyle(
                color: Color(0xFF575E67),
                fontFamily: 'Varela',
                fontSize: 24.0)),
      ),
      const SizedBox(height: 20.0),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 50.0,
          child: Text(product.description.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Color(0xFFB4B8B9))),
        ),
      ),
      const SizedBox(height: 20.0),
      Obx(
           () {
            return !cartController.click.value? Center(
              child: InkWell(
                // child: ch,
                onTap: () {
                  cartController.addItemToCart(product.id.toString(),product.title.toString(), double.parse(product.price.toString()), product.imageUrl.toString());
                },

                child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xFFF17532)),
                  child: const Center(
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ):Container();
          })
    ]);
  }
}
