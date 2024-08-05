import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internshala_mini_clone/models/internship.dart';

class ApiService {
  static const String apiUrl = 'https://internshala.com/flutter_hiring/search';

  Future<List<Internship>> fetchInternships() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> internshipsMeta = data['internships_meta'];
      List<Internship> internships = [];
      internshipsMeta.forEach((key, value) {
        internships.add(Internship.fromJson(value));
      });
      return internships;
    } else {
      throw Exception('Failed to load internships');
    }
  }

  Future<List<Internship>> fetchInternshipsWithFilters(Map<String, String> filters) async {
    Uri uri = Uri.parse(apiUrl);
    final newUri = uri.replace(queryParameters: filters);

    final response = await http.get(newUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> internshipsMeta = data['internships_meta'];
      List<Internship> internships = [];
      internshipsMeta.forEach((key, value) {
        internships.add(Internship.fromJson(value));
      });
      return internships;
    } else {
      throw Exception('Failed to load internships');
    }
  }
}
