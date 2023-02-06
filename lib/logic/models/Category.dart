import 'package:flutter/foundation.dart' show immutable;

@immutable
class Category {
  final int id;
  final String name;
  final String description;

  Category.fromMap(Map<dynamic, dynamic> json)
      : id = json["id"] ?? 0,
        name = json["name"],
        description = json["description"];
}
