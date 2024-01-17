import 'dart:convert';
import 'package:mobileapp/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<void> order(OrderModel orderInfo) async {
    Map<String, dynamic> data = orderInfo.toJson();

    final url = Uri.parse(
        "http://10.0.2.2:8000/api/v1/restaurant-management-system/order-dish/create");

    final response = await http.post(
      url,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print("Post successful");
    } else {
      print("Error when post data");
    }
  }
}
