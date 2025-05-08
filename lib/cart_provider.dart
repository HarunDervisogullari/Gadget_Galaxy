import 'package:flutter/material.dart';
class CartProvider with ChangeNotifier {
  Set<int> _cartProductIds = {};

  Set<int> get cartProductIds => _cartProductIds;

  void toggleFavorite(int productId) {
    if (_cartProductIds.contains(productId)) {
      _cartProductIds.remove(productId);
    } else {
      _cartProductIds.add(productId);
    }
    notifyListeners();
  }
}


