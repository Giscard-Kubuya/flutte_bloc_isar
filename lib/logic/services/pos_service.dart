import '../../utils/db_operations.dart';

class PosService {
  BdOperation bdd = BdOperation();
  Future getAllArticles() async {
    final data = await bdd.getAllProducts();
    return data;
  }

  Future getAllCommands() async {
    final data = await bdd.getAllCommands();
    return data;
  }

  Future getAllDetailsCommands(String code) async {
    final data = await bdd.getAllDetailsCommands(code);
    return data;
  }

  Future saveCommand(Map commands) async {
    final data = await bdd.saveCommand(commands);
    return data;
  }
}
