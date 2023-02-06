import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/logic/events/product_event.dart';
import 'package:store/logic/services/category_service.dart';
import 'package:store/logic/services/product_service.dart';
import 'package:store/logic/states/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState?> {
  ProductBloc() : super(null) {
    on<FetchAllProductEvent>(getAllProducts);
    on<FetchAllCategoryToProductEvent>(_getAllCategoryProd);
    on<GetOneProductEvent>(_findOne);
    on<AddProductEvent>(_addProduct);
    on<AddProductVisibleEvent>(_initAddProduct);
    on<DeleteItemEvent>(_deleteItem);
  }
  late final service = ProductService();
  late final categoryService = CategoryService();
  _initAddProduct(AddProductVisibleEvent ev, Emitter emit) async {
    final categories = await categoryService.getAllCategories();

    emit(IsAddProductState(categories));
  }

  _getAllCategoryProd(FetchAllCategoryToProductEvent ev, Emitter emit) async {
    final categories = await categoryService.getAllCategories();
    emit(GetAllCategoryProdList(categories));
  }

  getAllProducts(FetchAllProductEvent ev, Emitter emit) async {
    final products = await service.getAllProducts();
    emit(GetAllProductList(products));
  }

  _findOne(GetOneProductEvent ev, Emitter emit) async {
    final Map product = ev.product;
    final categories = await categoryService.getAllCategories();

    emit(GetOneProductState(product, categories));
  }

  getCategories() {
    return categoryService.getAllCategoriesStream();
  }

  _addProduct(AddProductEvent ev, Emitter emit) async {
    final Map product = ev.product;
    await service.addProduct(product);
    final categories = await service.getAllProducts();
    emit(GetAllProductList(categories));
  }

  _deleteItem(DeleteItemEvent ev, Emitter emit) async {
    int id = ev.id;
    await service.deleteProduct(id);
    final products = await service.getAllProducts();
    emit(GetAllProductList(products));
  }
}
