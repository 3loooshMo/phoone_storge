
// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_store_app/view/widgets/poroduct_grid_item.dart';
import '../../core/providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {

   ProductsGrid( {super.key});
  final ProductsController controller = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount:controller.productList.value.length,
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items in row
          childAspectRatio: 0.75,
          crossAxisSpacing: 10.0, // Space between columns
          mainAxisSpacing: 15, // Space between rows
        ),
        itemBuilder: (context, index) {
          return
             ProductGridItem(controller.productList.value[index]);

        });
  }
}
