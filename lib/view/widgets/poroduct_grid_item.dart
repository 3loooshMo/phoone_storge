// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_store_app/view/screens/product_details_screen.dart';
import '../../core/providers/cart_provider.dart';
import '../../core/providers/product_model_provider.dart';
class ProductGridItem extends StatelessWidget {
  final ProductModel product;

  ProductGridItem(this.product, {super.key});
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
          onTap: () {
            Get.to(() => ProductDetailsScreen(
                  index: product,
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
                tag: 'tage${product.id}',
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  height: 75.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(product.imageUrl!),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 7.0),
              Text(product.price.toString(),
                  style: const TextStyle(
                      color: Color(0xFFCC8053),
                      fontFamily: 'Varela',
                      fontSize: 14.0)),
              Text(product.title!,
                  style: const TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 14.0)),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(color: const Color(0xFFEBEBEB), height: 1.0)),
                Obx(
                   () {
                    return cartController.checkProductAddedTo.value ?
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                              child: const Icon(Icons.remove_circle_outline,
                                  color: Color(0xFFD17E50), size: 18.0),
                              onTap: () {
                                cartController.decreaseNumberOfProductsInCartItem(
                                    product.id.toString());
                                if (cartController.numberOfProductsInSingleItem(
                                        product.id!.toString()) ==
                                    0) {
                                  cartController
                                      .removeItemFromCart(product.id!.toString());
                                }
                              }),
                          Text(
                              cartController
                                  .numberOfProductsInSingleItem(
                                      product.id!.toString())
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
                                  product.id!.toString());
                            },
                          ),
                        ],
                      )
                    : Row(
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
                              cartController.checkProductAddedToCart(product.id);
                              cartController.addItemToCart(product.id!.toString(),
                                  product.title!, product.price!, product.imageUrl);
                              //  Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Added it to cart!'),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    cartController
                                        .removeItemFromCart(product.id!.toString());
                                  },
                                ),
                                //   ),
                              );
                            },
                          )
                        ],
                      );
                  }
                )
            ]),
          ),),
        );
  }
}
