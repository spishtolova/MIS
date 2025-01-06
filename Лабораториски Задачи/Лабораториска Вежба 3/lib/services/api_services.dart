import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = 'https://official-joke-api.appspot.com';

  static Future<List<String>> getJokeTypes() async {
    final response = await http.get(Uri.parse('$_baseUrl/types'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  static Future<List<dynamic>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('$_baseUrl/jokes/$type/ten'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load jokes of type $type');
    }
  }

  static Future<Map<String, dynamic>> getRandomJoke() async {
    final response = await http.get(Uri.parse('$_baseUrl/random_joke'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}
