import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/models/order_item.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;

  const OrderItemWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime!),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}
