import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ProductEvent {
  const ProductEvent();
}

class FetchAllProductEvent implements ProductEvent {}

class GetOneProductEvent implements ProductEvent {
  final Map product;
  GetOneProductEvent(this.product);
}

class AddProductEvent implements ProductEvent {
  final Map product;
  AddProductEvent(this.product);
}

class DeleteItemEvent implements ProductEvent {
  final int id;
  DeleteItemEvent(this.id);
}

class AddProductVisibleEvent implements ProductEvent {}

class FetchAllCategoryToProductEvent implements ProductEvent {}
