import 'package:store/logic/models/Product.dart';

import '../../utils/db_operations.dart';

class ProductService {
  BdOperation bdd = BdOperation();
  Future getAllProducts() async {
    final data = await bdd.getAllProducts();
    return data;
  }

  Future deleteProduct(int id) async {
    return await bdd.deleteProduct(id);
  }

  Future getOneProduct(int id) async {
    final data = await bdd.getOneProduct(id);
    return data;
  }

  Future addProduct(Map product) async {
    final data = await bdd.addProduct(product);
    return data;
  }
}
