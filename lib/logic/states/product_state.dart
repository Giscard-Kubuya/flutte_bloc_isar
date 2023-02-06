import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class GetAllProductList implements ProductState {
  final List products;

  GetAllProductList(this.products);
}

class GetOneProductState implements ProductState {
  final Map product;
  final List categories;
  GetOneProductState(this.product, this.categories);
}

class IsAddProductState implements ProductState {
  final List categories;
  IsAddProductState(this.categories);
}

class GetAllCategoryProdList implements ProductState {
  final List categories;

  GetAllCategoryProdList(this.categories);
}
