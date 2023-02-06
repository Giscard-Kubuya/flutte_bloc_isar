import 'dart:math';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store/utils/data_isar/category.dart';
import 'package:store/utils/data_isar/command.dart';
import 'package:store/utils/data_isar/command_produit.dart';
import 'package:store/utils/data_isar/product.dart';

class BdOperation {
  late Future<Isar> db;

  BdOperation() {
    db = openDB();
  }

  Stream<List<Category>> ListenToCategory() async* {
    final isar = await db;
    yield* isar.categorys.where().watch(fireImmediately: true);
  }

  Future<List<Category>> getAllCategories() async {
    final isar = await db;
    // final existingUser = await isar.categorys.get(1);
    return await isar.categorys.where().findAll();
  }

  Future saveCommand(Map commands) async {
    final isar = await db;

    final code = generateRandomString(4).toUpperCase();
    int total = 0;

    commands.forEach((key, value) {
      total += int.parse((value.price).toString());
    });
    final command = Command()
      ..code = code
      ..createdAtCom = DateTime.now()
      ..total = total;

    await isar.writeTxnSync(() async {
      isar.commands.putSync(command); // insert & update
    });

    final com =
        await isar.commands.where().filter().codeEqualTo(code).findFirst();

    commands.forEach((key, value) {
      final produit = Product()..id = int.parse((value.id).toString());
      final commandProduit = CommandProduit()
        ..commands.value = com
        ..products.value = produit
        ..price = value.price
        ..createdAtComProd = DateTime.now();

      isar.writeTxnSync(() {
        isar.commandProduits.putSync(commandProduit); // insert & update
      });
    });
    return true;
  }

  Future<bool> deleteCategory(int id) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.categorys.delete(id);
    });
  }

  Future<bool> deleteProduct(int id) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.products.delete(id);
    });
  }

  Future getAllProducts() async {
    final isar = await db;
    return await isar.products.where().findAll();
  }

  Future getAllCommands() async {
    final isar = await db;
    return await isar.commands.where().sortByCreatedAtComDesc().findAll();
  }

  Future getAllDetailsCommands(String code) async {
    final isar = await db;
    return await isar.commandProduits
        .where()
        .filter()
        .commands((q) => q.codeEqualTo(code))
        .sortByCreatedAtComProdDesc()
        .findAll();
  }

  Future getAllArticles() async {
    const obj = [
      {
        "article_name": "prod 1",
        "id": 1,
        "category_name": "Cat1",
        "prix_vente": 1500
      },
      {
        "article_name": "prod 2",
        "id": 2,
        "category_name": "Cat2",
        "prix_vente": 500
      },
    ];
    // Category data = Category.fromMap(obj as Map);
    return obj;
  }

  Future getOneCategory(int id) async {
    return {
      "name": "cate 1",
      "id": id,
      "description": "Veniam elit magna ipsum anim culpa qui ad ipsum",
      "prix_vente": 1500
    };
  }

  Future addCategory(Map category) async {
    final isar = await db;

    var id = category["id"];

    if (id != '') {
      final newCategory = Category()
        ..name = category["name"]
        ..description = category["description"]
        ..createdAtCat = new DateTime.now()
        ..id = int.parse(id.toString());

      await isar.writeTxn(() async {
        await isar.categorys.put(newCategory); // insert & update
      });
      return {
        "success": "true",
        "type": "edit",
        "data": category,
      };
    }

    final newCategory = Category()
      ..name = category["name"]
      ..description = category["description"]
      ..createdAtCat = new DateTime.now();

    await isar.writeTxn(() async {
      await isar.categorys.put(newCategory); // insert & update
    });

    return {
      "success": "true",
      "type": "add",
      "data": category,
    };
  }

  Future addProduct(Map product) async {
    final isar = await db;
    var id = product["id"];
    final category = Category()
      ..id = int.parse(product["category_id"].toString());
    Product newProduct;
    if (id != '') {
      newProduct = Product()
        ..name = product["name"]
        ..price = int.parse(product["price"].toString())
        ..category.value = category
        ..createdAtProd = DateTime.now()
        ..id = int.parse(id.toString());
    } else {
      newProduct = Product()
        ..price = int.parse(product["price"].toString())
        ..category.value = category
        ..name = product["name"]
        ..createdAtProd = DateTime.now();
    }

    await isar.writeTxnSync(() async {
      isar.products.putSync(newProduct); // insert & update
    });

    return {
      "success": "true",
      "type": id != '' ? "add" : "edit",
      "data": product,
    };
  }

  Future getOneProduct(int id) async {
    return {"name": "prod 6", "id": 11, "category_id": "2"};
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      // var dir = await getApplicationSupportDirectory();
      return await Isar.open(
          [CategorySchema, ProductSchema, CommandSchema, CommandProduitSchema],
          inspector: true);
    }
    // throw UnimplementedError();
    return Future.value(Isar.getInstance());
  }

  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return 'V$randomString'; // return the generated string
  }
}
