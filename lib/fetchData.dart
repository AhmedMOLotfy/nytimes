import 'dart:convert';

import 'package:nytimes/MainSection/parsedclass.dart';
import 'package:http/http.dart' as http;

Future<NYTimes> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=JXk3Kf2GgZZgmm8uTAYvoPmTliNxgCTL"));
  if (response.statusCode == 200) {
    return NYTimes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
