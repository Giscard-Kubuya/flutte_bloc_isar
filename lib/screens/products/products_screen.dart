import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/logic/blocs/product_bloc.dart';
import 'package:store/logic/events/product_event.dart';
import 'package:store/logic/states/product_state.dart';

class ProductInit extends StatelessWidget {
  const ProductInit({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ProductBloc(),
        child: const ProductsScreen(),
      ),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final bloc = BlocProvider.of<ProductBloc>(context);
  bool isActioning = true;
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category_id = TextEditingController();
  @override
  void initState() {
    super.initState();
    isActioning = true;
    bloc.add(FetchAllProductEvent());
  }

  @override
  void dispose() {
    id.dispose();
    name.dispose();
    category_id.dispose();
    price.dispose();
    super.dispose();
  }

  void initInput() {
    id.text = '';
    name.text = '';
    price.text = '';
    category_id.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          leading: Visibility(
            visible: isActioning != true,
            child: IconButton(
              onPressed: () {
                setState(() {
                  initInput();
                  isActioning = true;
                  bloc.add(FetchAllProductEvent());
                });
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          centerTitle: true,
          title: const Text('LISTE DES PRODUITS'),
        ),
        body: Column(
          children: [
            Expanded(child: BlocBuilder<ProductBloc, ProductState?>(
              builder: ((context, state) {
                if ((state is GetOneProductState ||
                        state is IsAddProductState) &&
                    isActioning == false) {
                  return formComponent();
                }
                if (state is GetAllProductList) {
                  final products = state.products;
                  return ListView.builder(
                    itemBuilder: (el, ind) {
                      final currentProduct = products[ind];
                      final cat = currentProduct?.category.value ?? '';
                      return GestureDetector(
                        onLongPress: () {
                          // print('want to delete');
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text('AlertDialog Title'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('Voulez-vous supprimer?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Oui'),
                                    onPressed: () {
                                      context.read<ProductBloc>().add(
                                            DeleteItemEvent(
                                              int.parse((currentProduct?.id)
                                                  .toString()),
                                            ),
                                          );
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Non'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(currentProduct?.name ?? ''),
                          subtitle: Text(
                            cat != '' ? cat?.name ?? '-' : '-',
                          ),
                          selectedTileColor: Colors.green,
                          selectedColor: Colors.white,
                          onTap: () {
                            context.read<ProductBloc>().add(
                                  GetOneProductEvent({
                                    "name": currentProduct?.name,
                                    "price": currentProduct?.price,
                                    "category_id":
                                        cat != '' ? cat?.name ?? 0 : 0,
                                    "id": currentProduct?.id
                                  }),
                                );
                            setState(() {
                              initInput();
                              isActioning = false;
                            });
                          },
                        ),
                      );
                    },
                    itemCount: products.length,
                  );
                } else if (state is GetOneProductState) {}
                return const SizedBox();
              }),
            ))
          ],
        ),
        floatingActionButton: Visibility(
          visible: isActioning,
          child: FloatingActionButton(
            onPressed: () {
              context.read<ProductBloc>().add(AddProductVisibleEvent());
              setState(() {
                initInput();
                isActioning = false;
              });
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  Visibility formComponent() {
    return Visibility(
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: const Color.fromARGB(255, 228, 226, 226),
              child: BlocBuilder<ProductBloc, ProductState?>(
                builder: ((context, state) {
                  if (state is GetOneProductState) {
                    final product = state.product;
                    // print(product);
                    id.text = product["id"].toString();
                    name.text = product["name"];
                    price.text = product["price"].toString();
                    category_id.text = 1.toString();
                  }
                  List categories = [];
                  // if (state is IsAddProductState) {
                  //   categories = state.categories;
                  // }

                  return Center(
                    child: Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              controller: name,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Product name"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              controller: price,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Product Price"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: StreamBuilder(
                              stream: bloc.getCategories(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return DropdownButton<String>(
                                    isExpanded: true,
                                    hint: const Text("Select Category"),
                                    items: (snapshot.data as List).map((value) {
                                      return DropdownMenuItem<String>(
                                        value: (value?.id).toString(),
                                        child: Text(value?.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (_) {
                                      setState(() {
                                        category_id.text = _!;
                                      });
                                    },
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            width: 200,
                            child: ElevatedButton(
                              child: const Text('SAVE'),
                              onPressed: () {
                                Map productSend = {
                                  "id": id.text.toString(),
                                  "name": name.text,
                                  "price": price.text,
                                  "category_id": category_id.text
                                };
                                setState(() {
                                  isActioning = true;
                                });
                                bloc.add(AddProductEvent(productSend));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // return const SizedBox();
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
