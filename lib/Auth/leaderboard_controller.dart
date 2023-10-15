import 'dart:convert';
import 'package:http/http.dart' as http;
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
