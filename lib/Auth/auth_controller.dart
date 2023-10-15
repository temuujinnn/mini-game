import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthController extends GetxController {
  AuthStatus _status = AuthStatus.loading;
  final phoneNumber = ''.obs;
  AuthStatus get status => _status;
  Future<void> loadUser() async {
    print('object ${_status}');

    await AuthService.getAccessToken().then((value) {
      print('value: $value');
      if (value != null) {
        _status = AuthStatus.authenticated;
      } else if (value == null) {
        _status = AuthStatus.unauthenticated;
      }
    }).catchError((e) {
      _status = AuthStatus.unauthenticated;
    });
    await AuthService.getPhoneNumber().then((value) {
      print('values: $value');
      if (value != null) {
        phoneNumber.value = value;
      } else if (value == null) {
        _status = AuthStatus.unauthenticated;
      }
    }).catchError((e) {
      print(e);
      _status = AuthStatus.unauthenticated;
      print('Logged out');
    });
  }

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
        final phoneNumber = jsonResponse['phoneNo'].toString();
        print(phoneNumber);
        _status = AuthStatus.authenticated;
        AuthService.saveAccessToken(accessToken);
        AuthService.savePhoneNumber(phoneNumber);

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
    phoneNumber.value = '';
    await AuthService.clearAccessToken();
    await AuthService.clearPhoneNumber();
    _status = AuthStatus.unauthenticated;
  }
}

class AuthService {
  static Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  static Future<void> savePhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }

  static Future<String?> getPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  static Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }

  static Future<void> clearPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('phonoeNumber');
  }
}
