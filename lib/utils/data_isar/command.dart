import 'package:isar/isar.dart';
part 'command.g.dart';

@collection
class Command {
  Id id = Isar.autoIncrement;
  String? code;
  int? total;
  DateTime? createdAtCom;
}
