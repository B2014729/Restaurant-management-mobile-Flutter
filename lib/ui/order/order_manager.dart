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

  List<OrderModel> get ordersHalfFirst {
    List<OrderModel> orderHalf = [];
    if (_orders.isNotEmpty) {
      for (var i = 0; i <= _orders.length / 2; i++) {
        orderHalf.add(_orders[i]);
      }
    }
    return orderHalf;
  }

  List<OrderModel> get ordersHalfFinal {
    List<OrderModel> orderHalf = [];

    if (_orders.length >= 2) {
      for (var i = _orders.length - 1; i > _orders.length / 2; i--) {
        orderHalf.add(_orders[i]);
      }
    }
    return orderHalf;
  }

  OrderModel? getOrderWithIdTable(idtable) {
    try {
      return _orders.firstWhere((order) => order.idTable == idtable);
    } catch (e) {
      return null;
    }
  }

  void addOrder(OrderModel newOrder) {
    _orders.insert(_orders.length, newOrder);

    notifyListeners();
  }

  void updateOrder(List<CartModel> lishDishAdd, int idtable) {
    for (var order in _orders) {
      if (order.idTable == idtable) {
        for (var dish in lishDishAdd) {
          order.dishList.add(dish);
        }
      }
    }
  }

  void clearOrder(int idtable) {
    _orders.removeWhere((order) => order.idTable == idtable);
    notifyListeners();
  }
}
