import 'package:watchat_ui/common/userVector.dart';

class Movie {
  int id;
  String title;
  String description;
  String imgPath;
  String redirectPath;
  UserVector vector;

  Movie(this.id, this.title, this.description, this.imgPath, this.redirectPath,
      this.vector);

  factory Movie.fromJson(dynamic json) {
    Map<String, dynamic> mapj = json as Map<String, dynamic>;
    mapj.forEach((key, value) {
      if (value == null) {
        mapj[key] = "Unknown";
        if (key == "image") {
          mapj[key] =
              "https://raw.githubusercontent.com/julien-gargot/images-placeholder/master/placeholder-portrait.png";
        }
        if (key == "redirect") {
          mapj[key] = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";
        }
      }
    });
    return Movie(mapj["id"], mapj["name"], mapj["description"], mapj["image"],
        mapj["redirect"], UserVector.fromJson(mapj["tags"]));
  }

  @override
  String toString() {
    return "Title: $title, description: $description, vector: $vector";
  }
}
