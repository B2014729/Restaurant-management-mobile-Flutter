import 'package:flutter/material.dart';
import 'package:mobileapp/models/cart_model.dart';

class CartManager with ChangeNotifier {
  final Map<String, CartModel> _items = {};

  int get dishCount {
    return _items.length;
  }

  List<CartModel> get dishs {
    return _items.values.toList();
  }

  Map toJSon(CartModel cart) {
    return {
      'idmon': cart.dishId,
      'soluong': cart.quantity,
      'ghichu': cart.note,
    };
  }

  void addItem(int dishId, int quantity, String note) {
    if (_items.containsKey('$dishId')) {
      _items.update(
        '$dishId',
        (existingCartItem) => existingCartItem.copyWith(
          quantity: quantity,
          note: note,
        ),
      );
    } else {
      _items.putIfAbsent(
        //function of Map
        '$dishId',
        () => CartModel(
          id: 'c${DateTime.now().toIso8601String()}',
          dishId: dishId,
          quantity: quantity,
          note: note,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(int dishId) {
    if (!_items.containsKey('$dishId')) {
      return;
    }
    if (_items[dishId]?.quantity as num > 1) {
      _items.update(
        '$dishId',
        (existingCartItem) =>
            existingCartItem.copyWith(quantity: existingCartItem.quantity - 1),
      );
    } else {
      _items.remove('$dishId');
    }
    notifyListeners();
  }

  void increaseDish(int dishId) {
    if (!_items.containsKey('$dishId')) {
      return;
    }
    _items.update(
      '$dishId',
      (existingCartItem) =>
          existingCartItem.copyWith(quantity: existingCartItem.quantity + 1),
    );
    notifyListeners();
  }

  void reduceDish(int dishId) {
    if (!_items.containsKey('$dishId')) {
      return;
    }
    _items.update(
      '$dishId',
      (existingCartItem) =>
          existingCartItem.copyWith(quantity: existingCartItem.quantity - 1),
    );
    notifyListeners();
  }

  void clearItem(int dishId) {
    _items.remove('$dishId');
    notifyListeners();
  }

  void clearAllItems() {
    _items.clear();
    notifyListeners();
  }
}
