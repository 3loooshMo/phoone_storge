import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_store_app/core/models/order_item.dart';
import 'package:phone_store_app/view/screens/orders_screen.dart';
import '../../view/widgets/bottom_app_bar.dart';
import '../providers/product_model_provider.dart';
import 'const.dart';

class FirebaseDb {
  static final getStorage = GetStorage();

  static addProduct(ProductModel productModel) async {
    await firebaseFirestore.collection('products_mobile').add({
      'title': productModel.title,
      'description': productModel.description,
      'imageUrl': productModel.imageUrl,
      'price': productModel.price,
      'id': productModel.id,
      'isDone': false,
    });
  }
static logOut(){
  FirebaseAuth.instance.signOut();
  getStorage.write("isLogin", false);

}
  static addOrder(OrderItem orderItem) async {
    await firebaseFirestore.collection('order').add({
      'id': orderItem.id,
      'amount': orderItem.amount,
      'phone': auth.currentUser!.phoneNumber,
      'name': getStorage.read("name"),
      'dateTime': orderItem.dateTime,
    });
  }

  static addUsersData(String name, String email, String address) async {
    await saveGetData(name, email, address);
    users.add({
      'name': name,
      'email': email,
      'address': address,
      'phone': auth.currentUser!.phoneNumber
    }).then((value) {
      print("User Added $value");
      Get.offAll(() => const SharedBottomAppBar());
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  static Stream<List<ProductModel>> productStream() {
    return firebaseFirestore
        .collection('products_mobile')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductModel> productMobile = [];
      for (var product in query.docs) {
        final products = ProductModel.fromDocumentSnapshot(product);
        productMobile.add(products);
      }
      return productMobile;
    });
  }
  static Stream<List<OrderItem>> orderStream() {
    return firebaseFirestore
        .collection('products_mobile').
        where('name', isEqualTo : getStorage.read("name")??"")
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderItem> productMobile = [];
      for (var product in query.docs) {
        final products = OrderItem.fromDocumentSnapshot(product);
        productMobile.add(products);
      }
      return productMobile;
    });
  }

  static updateStatus(bool isDone, documentId) {
    firebaseFirestore.collection('products_mobile').doc(documentId).update(
      {
        'isDone': isDone,
      },
    );
  }

  static deleteTodo(String documentId) {
    firebaseFirestore.collection('products_mobile').doc(documentId).delete();
  }

  static saveGetData(String name, String email, String address) {
    getStorage.write("isLogin", true);
    getStorage.write("name", name);
    getStorage.write("email", email);
    getStorage.write("address", address);
  }
}
