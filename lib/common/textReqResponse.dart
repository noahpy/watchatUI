import 'package:watchat_ui/common/movie.dart';
import 'package:watchat_ui/common/userVector.dart';

class TextReqResponse {
  List<Movie> movieList;
  String question;
  UserVector resVector;

  TextReqResponse(this.movieList, this.question, this.resVector);

  factory TextReqResponse.error() {
    return TextReqResponse(
        [], "An unexpected error occured...", UserVector([], []));
  }
}
