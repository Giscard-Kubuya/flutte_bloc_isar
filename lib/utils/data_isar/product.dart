import 'package:isar/isar.dart';
import 'package:store/utils/data_isar/category.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;
  int? price;
  String? name;
  DateTime? createdAtProd;
  final category = IsarLink<Category>();
}
