import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? name;

  String? description;

  DateTime? createdAtCat;
}
