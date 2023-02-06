import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class CategoryEvent {
  const CategoryEvent();
}

class FetchAllCategoryEvent implements CategoryEvent {}

class GetOneCategoryEvent implements CategoryEvent {
  final Map category;
  GetOneCategoryEvent(this.category);
}

class AddCategoryEvent implements CategoryEvent {
  final Map category;
  AddCategoryEvent(this.category);
}

class DeleteItemEvent implements CategoryEvent {
  final int id;
  DeleteItemEvent(this.id);
}

class AddCategoryVisibleEvent implements CategoryEvent {}
