import 'package:store/logic/models/Category.dart';

import '../../utils/db_operations.dart';

class CategoryService {
  BdOperation bdd = BdOperation();
  Future getAllCategories() async {
    final data = await bdd.getAllCategories();
    return data;
  }

  Future deleteCategory(int id) async {
    final data = await bdd.deleteCategory(id);
    return data;
  }

  Future getOneCategory(int id) async {
    final data = await bdd.getOneCategory(id);
    return data;
  }

  getAllCategoriesStream() {
    return bdd.ListenToCategory();
  }

  Future addCategory(Map category) async {
    final data = await bdd.addCategory(category);
    return data;
  }
}
