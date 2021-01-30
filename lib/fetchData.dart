import 'dart:convert';

import 'package:nytimes/MainSection/parsedclass.dart';
import 'package:http/http.dart' as http;

Future<NYTimes> fetchAlbum() async {
  final response = await http.get(
      'https://api.nytimes.com/svc/topstories/v2/politics.json?api-key=GMp2TxpCQsMP2GQA3uqjzCbsQAkIcSDu');
  if (response.statusCode == 200) {
    return NYTimes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
