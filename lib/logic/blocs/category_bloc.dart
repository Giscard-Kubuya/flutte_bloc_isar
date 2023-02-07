import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/logic/events/category_event.dart';
import 'package:store/logic/services/category_service.dart';
import 'package:store/logic/states/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState?> {
  CategoryBloc() : super(null) {
    on<FetchAllCategoryEvent>(_getAllCategory);
    on<GetOneCategoryEvent>(_findOne);
    on<AddCategoryEvent>(_addCategory);
    on<AddCategoryVisibleEvent>(_initAddCategory);
    on<DeleteItemEvent>(_deleteItem);
  }
  late final service = CategoryService();

  _initAddCategory(AddCategoryVisibleEvent ev, Emitter emit) {
    emit(IsAddCategoryState());
  }

  _getAllCategory(FetchAllCategoryEvent ev, Emitter emit) async {
    final categories = await service.getAllCategories();
    emit(GetAllCategoryList(categories));
  }

  _deleteItem(DeleteItemEvent ev, Emitter emit) async {
    int id = ev.id;
    await service.deleteCategory(id);
    final categories = await service.getAllCategories();
    emit(GetAllCategoryList(categories));
  }

  _findOne(GetOneCategoryEvent ev, Emitter emit) async {
    final Map category = ev.category;
    emit(GetOneCategoryState(category));
  }

  _addCategory(AddCategoryEvent ev, Emitter emit) async {
    final Map category = ev.category;
    await service.addCategory(category);
    final categories = await service.getAllCategories();
    emit(GetAllCategoryList(categories));
  }
}
