import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/dish_model.dart';

class DishManager with ChangeNotifier {
  static final List<DishModel> _items = [];

  Future<void> fectDishListFromAPI() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/v1/restaurant-management-system/dish/list'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<dynamic> data = jsonData['data'];
      for (var i = 0; i < data.length; i++) {
        Map<String, dynamic> jsonDish = {};
        jsonDish['id'] = data[i]['idmon'];
        jsonDish['price'] = data[i]['gia'];
        jsonDish['name'] = data[i]['tenmon'];
        jsonDish['imageUrl'] = data[i]['hinhanh'];
        jsonDish['type'] = data[i]['idloai'];
        jsonDish['unit'] = data[i]['iddonvitinh'];

        _items.add(DishModel.fromJson(jsonDish));
      }
    } else {
      // Handle error if needed
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<DishModel> get items {
    return [..._items];
  }

  List<DishModel> itemsOnType(int type) {
    List<DishModel> itemOnType = [];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].type == type) {
        itemOnType.add(_items[i]);
      }
    }
    return itemOnType;
  }

  static get id => null;

  DishModel? findById(int id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  // DishModel? findByTitle(String title) {
  //   try {
  //     return _items.firstWhere((item) => item.title == title);
  //   } catch (error) {
  //     return null;
  //   }
  // }
}
