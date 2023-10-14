import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthService {
  static Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  static Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }
}

class AuthController {
  AuthStatus _status = AuthStatus.loading;
  AuthStatus get status => _status;

  Future<void> loginPhoneNumber(String phoneNumber) async {
    final url = Uri.parse('http://18.184.93.1:4050/api/auth/login');
    final Map<String, String> headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'phoneNo': phoneNumber,
    };

    try {
      _status = AuthStatus.loading;
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final accessToken = jsonResponse["accessToken"];
        _status = AuthStatus.authenticated;
        AuthService.saveAccessToken(accessToken);

        // Successful response, you can handle it here
        print("Login successful");

        print(response.body);
      } else {
        _status = AuthStatus.unauthenticated;
        // Handle error cases, e.g., authentication failure
        print("Login failed");
      }
    } catch (e) {
      // Handle network or other exceptions
      print("An error occurred: $e");
    }
  }

  Future<void> logout() async {
    await AuthService.clearAccessToken();
    _status = AuthStatus.unauthenticated;
  }

  Future<void> loadUser() async {
    print('object');

    await AuthService.getAccessToken().then((value) {
      print('value: $value');
      if (value != null) {
        print('value: $value');
        _status = AuthStatus.authenticated;
        print(_status);
        print("Logged in");
      } else {
        _status = AuthStatus.unauthenticated;
      }
    }).catchError((e) {
      print(e);
      _status = AuthStatus.unauthenticated;
      print('Logged out');
    });
  }
}
