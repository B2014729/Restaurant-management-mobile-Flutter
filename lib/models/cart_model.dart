import 'package:mobileapp/models/dish_model.dart';

class CartModel {
  final String id;
  final int dishId;
  final int quantity;
  final String note;

  CartModel({
    required this.id,
    required this.dishId,
    required this.quantity,
    required this.note,
  });

  Map<String, dynamic> toJson(CartModel cart) {
    return {
      'id': cart.id,
      'dishId': cart.dishId,
      'quantity': cart.quantity,
      'note': cart.note
    };
  }

  CartModel copyWith({
    String? id,
    DishModel? dish,
    int? quantity,
    String? note,
  }) {
    return CartModel(
      id: id ?? this.id,
      dishId: dishId,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
    );
  }

  int get idDishOnCart {
    return dishId;
  }

  int get quantityOnCart {
    return quantity;
  }

  String get noteOnCart {
    return note;
  }
}
