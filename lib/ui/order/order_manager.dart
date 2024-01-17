import 'package:flutter/material.dart';
import 'package:mobileapp/models/cart_model.dart';
import 'package:mobileapp/models/order_model.dart';

class OrderManager with ChangeNotifier {
  final List<OrderModel> _orders = [];

  int get orderCount {
    return _orders.length;
  }

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(int idtable, int status, String token, List<CartModel> carts) {
    _orders.insert(
      0,
      OrderModel(
        idTable: idtable,
        status: status,
        token: token,
        dishList: carts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
