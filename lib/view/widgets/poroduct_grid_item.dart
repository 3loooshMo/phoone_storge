// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_store_app/view/screens/product_details_screen.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/product_model_provider.dart';

class ProductGridItem extends StatefulWidget {
  final ProductModel product;

  const ProductGridItem(this.product, {super.key});

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDetailsScreen(
                index: widget.product,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Hero(
              tag: 'tage${widget.product.id}',
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 18),
                height: 75.0,
                width: 130.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.product.imageUrl!),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: 7.0),
            Text(widget.product.price.toString(),
                style: const TextStyle(
                    color: Color(0xFFCC8053),
                    fontFamily: 'Varela',
                    fontSize: 14.0)),
            Text(widget.product.title!,
                style: const TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 14.0)),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(color: const Color(0xFFEBEBEB), height: 1.0)),
            Obx(
               () {
                return cartController.checkProductAddedToCart(widget.product.id)
                    ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        child: const Icon(Icons.remove_circle_outline,
                            color: Color(0xFFD17E50), size: 18.0),
                        onTap: () {
                          cartController.decreaseNumberOfProductsInCartItem(
                              widget.product.id.toString());
                          if (cartController.numberOfProductsInSingleItem(
                              widget.product.id.toString()) ==
                              0) {
                            cartController.removeItemFromCart(widget.product.id.toString());
                          }
                        }),
                    Text(
                        cartController
                            .numberOfProductsInSingleItem(widget.product.id.toString())
                            .toString(),
                        style: const TextStyle(
                            fontFamily: 'Varela',
                            color: Color(0xFFD17E50),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0)),
                    InkWell(
                      child: const Icon(Icons.add_circle_outline,
                          color: Color(0xFFD17E50), size: 18.0),
                      onTap: () {
                        cartController.increaseNumberOfProductsInCartItem(
                            widget.product.id.toString());
                      },
                    ),
                  ],
                )
                    :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Icon(Icons.shopping_basket,
                        color: Color(0xFFD17E50), size: 16.0),
                    InkWell(
                      child: const Text('Add to cart',
                          style: TextStyle(
                              fontFamily: 'Varela',
                              color: Color(0xFFD17E50),
                              fontSize: 14.0)),
                      onTap: () {
                        cartController.addItemToCart(widget.product.id.toString(), widget.product.title!,
                            widget.product.price!, widget.product.imageUrl);

                       // Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Added it to cart!'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                cartController.removeItemFromCart(widget.product.id.toString());
                              },
                            ),
                       //   ),
                        );
                      },
                    )
                  ],
                );
              }
            ),
          ]),
        ),
      ),
    );
  }
}
