class UserVector {
  List<String> names = [];
  List<double> values = [];

  double sweight = 0.4;
  double nweight = 1;

  UserVector(this.names, this.values);

  factory UserVector.fromJson(List<dynamic> jsonList) {
    List<String> names = [];
    List<double> values = [];
    for (Map<String, dynamic> json in jsonList) {
      names.add(json["name"]);
      values.add(json["match"]);
    }
    return UserVector(names, values);
  }

  List<Map<String, dynamic>> toJsonList() {
    List<Map<String, dynamic>> result = [];
    for (int i = 0; i < names.length; i++) {
      result.add({"name": names[i], "match": values[i]});
    }
    return result;
  }

  @override
  String toString() {
    return names.toString();
  }
}
