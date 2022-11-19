import 'package:watchat_ui/common/userVector.dart';

class Movie {
  int id;
  String? title;
  String? description;
  String? imgPath;
  String? redirectPath;
  UserVector vector;

  Movie(this.id, this.title, this.description, this.imgPath, this.redirectPath,
      this.vector);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(json["id"], json["name"], json["description"], json["image"],
        json["redirect"], UserVector.fromJson(json["tags"]));
  }

  @override
  String toString() {
    return "Title: $title, description: $description, vector: $vector";
  }
}
