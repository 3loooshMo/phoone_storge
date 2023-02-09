
import 'package:get/get.dart';
import 'package:phone_store_app/core/providers/product_model_provider.dart';

import '../Firebase/firebase_db.dart';
class ProductsController extends GetxController {

  Rx<List<ProductModel>> productList = Rx<List<ProductModel>>([]);
  List<ProductModel> get product => productList.value;

  @override
  void onReady() {
    productList.bindStream(FirebaseDb.productStream());
  }
  void change(int index){
    productList.value[index].isFavorite = !productList.value[index].isFavorite;
  }
}