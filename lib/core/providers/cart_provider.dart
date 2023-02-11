import 'package:get/get.dart';
import '../models/cart_item.dart';
class CartController extends GetxController {
  final RxMap<String, CartItem> _cartItems = <String, CartItem>{}.obs;
  RxBool click = false.obs;
  RxBool checkProductAddedTo = false.obs;

  RxMap<String, CartItem> get cartItems {
    return {..._cartItems}.obs;
  }
  RxInt get itemsCount => _cartItems.length.obs;
  double get totalPriceAmount {
    var total = 0.0.obs;
    _cartItems.forEach((key, cardItem) {
      total.value += cardItem.price! * cardItem.quantity!;
    });
    return total.value;
  }

  bool checkProductAddedToCart(productId) {
    if (_cartItems.containsKey(productId)) {
      checkProductAddedTo.value = true;
      return true;
    } else {
      checkProductAddedTo.value = false;
      return false;
    }
  }

  int numberOfProductsInSingleItem(String productId) {
    var cartItem =
        _cartItems.values.firstWhere((cartItem) => cartItem.id == productId);
    return cartItem.quantity!;
  }

  void increaseNumberOfProductsInCartItem(String productId) {
    _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              quantity: existingCartItem.quantity! + 1,
            ));
    update();
  }

  void decreaseNumberOfProductsInCartItem(String productId) {
    _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              quantity: (existingCartItem.quantity == 0)
                  ? 0
                  : existingCartItem.quantity! - 1,
            ));
    update();
  }

  void addItemToCart(
      String productId, String title, double price, String? imageUrl) {
    if (_cartItems.containsKey(productId)) {
      // Increase quantity
      checkProductAddedToCart(productId);
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                imageUrl: existingCartItem.imageUrl,
                quantity: existingCartItem.quantity! + 1,
              ));
    } else {
      checkProductAddedToCart(productId);
      // Add product to cart
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
                id: productId,
                title: title,
                imageUrl: imageUrl,
                quantity: 1,
                price: price,
              ));
    }
    update();
  }

  void removeItemFromCart(String itemId) {
    _cartItems.remove(itemId);
    update();
  }

  void clearCart() {
    _cartItems.value = {};
    update();
  }
}
