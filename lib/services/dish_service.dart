// import 'package:http/http.dart' as http;
// import 'package:mobileapp/models/dish_model.dart';

// class DishService {
//   static var client = http.Client();

//   static Future<DishModel> fetchData() async {
//     final uri = Uri.parse(
//         "http://10.0.2.2:8000/api/v1/restaurant-management-system/dish/list");
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       return DishModel.fromJson({
//         "id": 1,
//         "name": "Gỏi xoài tôm khô",
//         "price": 90000,
//         "imageUrl":
//             "https://bepnha.kingfoodmart.com/wp-content/uploads/2021/10/cach-lam-goi-xoai-tron-tom-kho-mon-khai-vi-326265996410.jpg",
//         "unit": 4,
//         "type": 10
//       });
//     } else {
//       print('CHECK ERROR');
//       throw Exception("Fetch data failed!");
//     }
//   }
// }
