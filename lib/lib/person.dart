import 'package:flutter/foundation.dart' show immutable;

@immutable
class Person {
  final String name;
  final int age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        age = json["age"] as int;
}
