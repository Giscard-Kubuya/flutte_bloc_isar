class Product {
  int id;
  int refCategory;
  String productName;
  String createdAt;

  Product.fromMap(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        refCategory = json["refCategory"],
        productName = json["productName"],
        createdAt = json["createdAt"];
}
