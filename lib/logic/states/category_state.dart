import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {}

class GetAllCategoryList implements CategoryState {
  final List categories;

  GetAllCategoryList(this.categories);
}

class GetOneCategoryState implements CategoryState {
  final Map category;

  GetOneCategoryState(this.category);
}

class IsAddCategoryState implements CategoryState {}
