import 'package:mobileapp/models/cart_model.dart';
import 'package:mobileapp/models/dish_model.dart';
import 'package:mobileapp/ui/dish/dish_manager.dart';

class OrderModel {
  final int idTable;
  final int status;
  final String token;
  final List<CartModel> dishList;
  final DateTime dateTime;

  OrderModel({
    required this.idTable,
    required this.status,
    required this.token,
    required this.dishList,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderModel coppyWith({
    int? idTable,
    int? status,
    String? token,
    List<CartModel>? dishList,
    DateTime? dateTime,
  }) {
    return OrderModel(
      idTable: idTable ?? this.idTable,
      status: status ?? this.status,
      token: token ?? this.token,
      dishList: dishList ?? this.dishList,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    List<int> idDish = [];
    List<int> quantity = [];
    List<String> note = [];
    for (int i = 0; i < dishCount; i++) {
      idDish.add(dishList[i].idDishOnCart);
      quantity.add(dishList[i].quantityOnCart);
      note.add(dishList[i].noteOnCart);
    }
    return {
      'idTable': idTable,
      'dateTime ': dateTime.toString(),
      'status': status,
      'token': 'kkkkkkkkkkkk',
      'idDish': idDish,
      'quantity': quantity,
      'note': note
    };
  }

  int get dishCount {
    return dishList.length;
  }

  List<Map<String, dynamic>> getListDishInOrder() {
    List<Map<String, dynamic>> result = [];

    for (var cart in dishList) {
      DishModel? dish = DishManager().findById(cart.dishId);
      if (dish != null) {
        result.add({
          'dishName': dish.name,
          'dishPrice': dish.price,
          'quantity': cart.quantity,
        });
      }
    }
    return result;
  }

  int totalPayment() {
    int total = 0;
    for (var cart in dishList) {
      DishModel? dish = DishManager().findById(cart.dishId);
      if (dish != null) {
        total = total + ((dish.price * cart.quantity));
      }
    }
    return total;
  }

  List<CartModel> get listCart {
    return dishList;
  }
}
