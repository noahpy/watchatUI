import 'dart:convert';

import 'package:watchat_ui/common/movie.dart';
import 'package:watchat_ui/common/textReqResponse.dart';
import 'package:watchat_ui/common/userVector.dart';
import 'package:http/http.dart' as http;

class ReqController {
  static String apiURL = "https://watchat-backend.herokuapp.com";

  static Future<TextReqResponse> postResponse(
      {String text =
          "a comedic philatrophy of a lonely man in a huge city, battling with cancer"}) async {
    late final http.Response response;
    try {
      response = await http.post(Uri.parse('$apiURL/message'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              json.encode(<String, dynamic>{"preferences": [], "text": text}));
    } catch (e) {
      print(e);
      return TextReqResponse.error();
    }

    dynamic res = json.decode(const Utf8Decoder().convert(response.bodyBytes));

    List<Movie> movies = [];
    for (dynamic json in res["movies"]) {
      movies.add(Movie.fromJson(json));
    }
    UserVector vectorFromText = UserVector.fromJson(res["tagsFromText"]);
    String question = res["question"];

    return TextReqResponse(movies, question, vectorFromText);
  }
}
