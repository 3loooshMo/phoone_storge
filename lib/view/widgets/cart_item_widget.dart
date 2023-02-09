// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String? itemId;
  final String? productId;
  final double? price;
  final int? quantity;
  final String? title;
  final String? imageUrl;

  CartItemWidget({super.key,
    this.itemId,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  });
  CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(itemId),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you remove the item from the cart?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        controller
            .removeItemFromCart(itemId!);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(title!),
              subtitle: Text('Total: \$${(price! * quantity!)}'),
              trailing: Text('$quantity x'),
            ),
            const Divider(
              thickness: 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
