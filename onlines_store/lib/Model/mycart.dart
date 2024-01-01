import 'package:flutter/foundation.dart';

class CartItem {
  final int productId;
  final String productName;
  final double price;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }
}
