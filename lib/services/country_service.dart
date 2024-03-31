import 'dart:convert';

import 'package:http/http.dart' as http;

class CountryService {
  static const String baseUrl = "https://restcountries.com/v3.1/";

  static Future<List<String>> getListCountry(String? countryName) async {
    List<String> listCountry = [];
    String url = countryName == null
        ? "${baseUrl}all?fields=name"
        : "${baseUrl}name/$countryName";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      for (var country in data) {
        listCountry.add(country['name']['common']);
      }
    }

    return listCountry;
  }
}
