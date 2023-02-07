import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/logic/blocs/category_bloc.dart';
import 'package:store/logic/events/category_event.dart';
import 'package:store/utils/data_isar/category.dart';

import '../../logic/states/category_state.dart';

class CategoryInit extends StatelessWidget {
  const CategoryInit({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _CategoryScreenState() : super();
  late final bloc = BlocProvider.of<CategoryBloc>(context);
  bool isActioning = true;
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    super.initState();
    isActioning = true;
    bloc.add(FetchAllCategoryEvent());
    // final getCategories = BlocProvider.of<CategoryBloc>(context);
  }

  @override
  void dispose() {
    id.dispose();
    name.dispose();
    description.dispose();
    super.dispose();
  }

  void initInput() {
    id.text = '';
    name.text = '';
    description.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LISTE DES CATEGORIES'),
        centerTitle: true,
        leading: Visibility(
            visible: isActioning != true,
            child: IconButton(
              onPressed: () {
                setState(() {
                  initInput();
                  isActioning = true;
                  bloc.add(FetchAllCategoryEvent());
                });
              },
              icon: const Icon(Icons.arrow_back),
            )),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: StreamBuilder<List<Category>>(
          //     stream: BlocProvider.of<CategoryBloc>(context).getAll(),
          //     builder: (context, snapshot) {
          //       print(snapshot.data as List<Category>);
          //       return SizedBox();
          //     },
          //   ),
          // ),
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState?>(
              builder: ((context, state) {
                if ((state is GetOneCategoryState ||
                        state is IsAddCategoryState) &&
                    isActioning == false) {
                  return formComponent();
                }
                if (state is GetAllCategoryList) {
                  final categories = state.categories;
                  return ListView.builder(
                    itemBuilder: (el, ind) {
                      final currentCategory = categories[ind];
                      return GestureDetector(
                        onLongPress: () {
                          // print('want to delete');
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text('Alert'),
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
                                      context.read<CategoryBloc>().add(
                                            DeleteItemEvent(
                                              int.parse((currentCategory?.id)
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
                          title: Text(currentCategory?.name ?? ''),
                          subtitle: Text(
                            currentCategory?.description ?? '',
                          ),
                          selectedTileColor: Colors.green,
                          selectedColor: Colors.white,
                          onTap: () {
                            context.read<CategoryBloc>().add(
                                  GetOneCategoryEvent({
                                    "id": currentCategory?.id ?? '',
                                    "name": currentCategory?.name ?? '',
                                    "description":
                                        currentCategory?.description ?? ''
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
                    itemCount: categories.length,
                  );
                }
                return const SizedBox();
              }),
            ),
          )
        ],
      ),
      // if(bloc.state is GetOneCategoryState)
      floatingActionButton: Visibility(
        visible: isActioning,
        child: FloatingActionButton(
          onPressed: () {
            context.read<CategoryBloc>().add(AddCategoryVisibleEvent());
            setState(() {
              initInput();
              isActioning = false;
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Visibility formComponent() {
    // setState(() {
    if (bloc.state is GetOneCategoryState) {}
    // });
    return Visibility(
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              // width: 25.0,

              alignment: Alignment.center,
              color: const Color.fromARGB(255, 228, 226, 226),
              child: BlocBuilder<CategoryBloc, CategoryState?>(
                builder: ((context, state) {
                  if (state is GetOneCategoryState) {
                    final category = state.category;
                    id.text = category["id"].toString();
                    name.text = category["name"];
                    description.text = category["description"];
                  }
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Category name"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: description,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Description"),
                          ),
                        ),
                        SizedBox(
                            height: 35,
                            width: 200,
                            child: ElevatedButton(
                              child: const Text('SAVE'),
                              onPressed: () {
                                Map categorySend = {
                                  "id": id.text.toString(),
                                  "name": name.text,
                                  "description": description.text,
                                  "createdAtCat": new DateTime.now()
                                };
                                setState(() {
                                  isActioning = true;
                                });
                                bloc.add(AddCategoryEvent(categorySend));
                              },
                            )),
                      ],
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
