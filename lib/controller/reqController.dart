import 'dart:convert';

import 'package:watchat_ui/common/movie.dart';
import 'package:watchat_ui/common/textReqResponse.dart';
import 'package:watchat_ui/common/userVector.dart';
import 'package:http/http.dart' as http;

class ReqController {
  static String apiURL = "https://watchat-backend.herokuapp.com";

  static Future<TextReqResponse> postResponse(
      {String text =
          "a comedic philatrophy of a lonely man in a huge city, battling with cancer", UserVector? preferences}) async {
    late final http.Response response;
    try {
      response = await http.post(Uri.parse('$apiURL/message'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              json.encode(<String, dynamic>{"preferences": preferences == null? [] : preferences.toJsonList(), "text": text}));
    } catch (e) {
      print(e);
      return TextReqResponse.error();
    }

    if (response.statusCode == 200) {
      dynamic res =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));
      List<Movie> movies = [];
      for (dynamic json in res["movies"]) {
        movies.add(Movie.fromJson(json));
      }

      UserVector vectorFromText = UserVector.fromJson(res["tagsFromText"]);
      String question = res["question"];
      if (question == "Test question" || question == "") {
        question = "These might suit you!";
      }

      return TextReqResponse(movies, question, vectorFromText);
    } else {
      return TextReqResponse.error();
    }
  }
}
