import 'package:isar/isar.dart';
import 'package:store/utils/data_isar/command.dart';
import 'package:store/utils/data_isar/product.dart';

part 'command_produit.g.dart';

@collection
class CommandProduit {
  Id id = Isar.autoIncrement;
  int? price;
  final products = IsarLink<Product>();
  final commands = IsarLink<Command>();
  DateTime? createdAtComProd;
}
