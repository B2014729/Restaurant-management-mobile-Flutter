import 'package:http/http.dart' as http;

class AuthService {
  static Future<String?> login(String username, String password) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/v1/restaurant-management-system/account/login");
    final response = await http.post(url, body: {
      "username": username,
      "password": password,
    });

    if (response.statusCode == 200) {
      return response.headers['authorization'];
    }
    return '';
  }
}
