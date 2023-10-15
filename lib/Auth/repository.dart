import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_app/Auth/auth_controller.dart';
import 'package:mini_app/models/leaderboard_model.dart';

Future<List<LeaderBoardModel>> fetchScoreboard() async {
  final url = Uri.parse('http://18.184.93.1:4050/api/scoreboard/');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];
      final scoreboardList =
          data.map((item) => LeaderBoardModel.fromJson(responseData)).toList();

      return scoreboardList;
    } else {
      throw Exception('Failed to load scoreboard data');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the request
    throw Exception('Network request error: $e');
  }
}

Future<void> chargeGame() async {
  final String url = "https://mock.apidog.com/m1/398946-0-default/charge";

  // Create the request body
  Map<String, dynamic> requestBody = {
    "mobileNo": 99111199,
    "txnAmt": 1000,
    "txnCur": "ACO",
    "txnDesc": "Charging Mini game.",
    "registerNo": "УП99111199"
  };

  // Convert the request body to JSON
  String requestBodyJson = jsonEncode(requestBody);

  // Send the POST request
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Set the content type
      },
      body: requestBodyJson,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      print("Response: ${response.body}");
    } else {
      print("Request failed with status code: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future<void> sendScoreData(score) async {
  final url = Uri.parse('http://18.184.93.1:4050/api/scoreboard/');
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTJhMjNhZjRmYzA4M2I5M2I4NGJhMzMiLCJwaG9uZU5vIjo5OTExMDA0NSwiaWF0IjoxNjk3MjYxOTU2LCJleHAiOjE2OTc4NjY3NTZ9.P4e7El1213JphGpvx8Bap5BqhMxM01LLUHttpnPyipw';

  final headers = {
    'accept': 'application/json',
    'authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'score': score,
    'survivalDuration': score,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Success: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
