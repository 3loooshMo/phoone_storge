import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'cart_item.dart';

class OrderItem {
   String? id;
   double? amount;
   List<CartItem>? products;
   DateTime dateTime = DateTime.now();

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
  OrderItem.fromDocumentSnapshot( DocumentSnapshot documentSnapshot) {
    id = documentSnapshot["id"];
    amount = documentSnapshot["amount"];
    dateTime = documentSnapshot["dateTime"];
  }
}
