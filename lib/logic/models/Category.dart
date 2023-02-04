class Category {
  String name;
  String description;

  Category.fromMap(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"];
}
