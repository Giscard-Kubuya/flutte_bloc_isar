import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/logic/blocs/pos_bloc.dart';
import 'package:store/logic/events/pos_event.dart';
import 'package:store/logic/states/pos_state.dart';
import 'package:store/screens/pos/pos_article.dart';
import 'package:store/utils/data_isar/command.dart';
import 'package:store/utils/data_isar/command_produit.dart';

class HomeInit extends StatelessWidget {
  const HomeInit({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (ctx) => PosBloc(),
        child: const PosHome(),
      ),
    );
  }
}

class PosHome extends StatefulWidget {
  const PosHome({super.key});

  @override
  State<PosHome> createState() => _PosHomeState();
}

class _PosHomeState extends State<PosHome> {
  late final bloc = BlocProvider.of<PosBloc>(context);
  String title = 'LISTE DES VENTES';
  bool isDetails = false;

  @override
  void initState() {
    super.initState();
    bloc.add(InitCommandEvent());
  }

  initCustom() {
    if (isDetails) {
      title = 'DETAILS';
    } else {
      title = 'LISTE DES VENTES';
    }
    handleAction();
  }

  Widget handleAction() {
    return isDetails
        ? IconButton(
            onPressed: () {
              setState(() {
                isDetails = false;
                initCustom();
              });
              bloc.add(InitCommandEvent());
            },
            icon: const Icon(Icons.arrow_back),
          )
        : IconButton(
            onPressed: () {
              setState(() {
                isDetails = false;
                initCustom();
              });
              Navigator.push(
                context,
                MaterialPageRoute<PosArticle>(
                    builder: (ctx) => BlocProvider.value(
                          value: BlocProvider.of<PosBloc>(context),
                          child: const PosArticle(),
                        )),
              );
            },
            icon: const Icon(Icons.add_shopping_cart_rounded),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(title),
        actions: [handleAction()],
      ),
      body: Column(
        children: [
          Expanded(child: BlocBuilder<PosBloc, PosState?>(
            builder: ((context, state) {
              if (state is InitCommandState) {
                final commands = state.commands;
                return ListView.builder(
                  itemBuilder: (el, ind) {
                    final currentCommand = commands[ind];
                    // final product = currentCommand?.product.value ?? '';
                    return Center(
                      child: ListTile(
                        title: Text(
                            "${(currentCommand?.code ?? '').toUpperCase()}"),
                        subtitle: Text("${currentCommand?.createdAtCom}"),
                        leading: Text("${currentCommand?.total}"),
                        selectedTileColor: Colors.green,
                        selectedColor: Colors.white,
                        onTap: () {
                          context.read<PosBloc>().add(
                                FechtDetailsCommandEvent(currentCommand?.code),
                              );
                          setState(() {
                            isDetails = true;
                            initCustom();
                          });
                        },
                      ),
                    );
                  },
                  itemCount: commands.length,
                );
              }

              if (state is FechtDetailsCommandState) {
                final detailsComm = state.detailsCommand;

                return ListView.builder(
                    itemBuilder: ((context, index) {
                      final currentDetails = detailsComm[index];
                      final product = currentDetails?.products.value ?? '';
                      // final command = currentDetails?.products.value ?? '';
                      return Column(
                        children: [
                          ListTile(
                            title: Text(product?.name),
                            leading: Text("${product?.price}"),
                          )
                        ],
                      );
                    }),
                    itemCount: detailsComm.length);
              }
              return const SizedBox();
            }),
          ))
        ],
      ),
    );
  }
}
