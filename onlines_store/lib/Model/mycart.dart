import 'package:flutter/foundation.dart';

class CartItem {
  final int productId;
  final String productName;
  final double price;
  final String image;

  CartItem({
    required this.image,
    required this.productId,
    required this.productName,
    required this.price,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> mycartitems = [];

  List<CartItem> get items => mycartitems;

  void addToCart(CartItem item) {
    mycartitems.add(item);
    notifyListeners();
  }

  int get cartItemCount => mycartitems.length;
  void removeFromCart(CartItem item) {
    mycartitems.remove(item);
    notifyListeners();
  }
}
