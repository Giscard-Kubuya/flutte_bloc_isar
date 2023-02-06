import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/logic/blocs/pos_bloc.dart';
import 'package:store/logic/events/pos_event.dart';
import 'package:store/logic/states/pos_state.dart';

class PosArticle extends StatefulWidget {
  const PosArticle({super.key});

  @override
  State<PosArticle> createState() => _PosArticleState();
}

class _PosArticleState extends State<PosArticle> {
  late final bloc = BlocProvider.of<PosBloc>(context);
  int totalInCart = 0;
  Map cartC = {};
  @override
  void initState() {
    super.initState();
    bloc.add(SetCommandEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initCart(map, ind) {
    cartC.forEach((key, value) {
      if (ind == key) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cet article existe deja')));
      }
    });
    cartC[ind] = map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ARTICLES'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            bloc.add(InitCommandEvent());
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Center(
        child: BlocBuilder<PosBloc, PosState?>(
          builder: (context, state) {
            if (state is SetCommandState) {
              List articles = state.articles;
              return ListView.builder(
                  itemBuilder: ((context, index) {
                    final article = articles[index];
                    return Center(
                        child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue,
                        onTap: () {
                          initCart(article, index);
                          setState(() {
                            totalInCart = cartC.length;
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 300,
                          child: ListTile(
                            title: Text(article.name),
                            // leading: Text("${article.price}"),
                            subtitle: Text("${article.price}BIF"),
                          ),
                        ),
                      ),
                    ));
                  }),
                  itemCount: articles.length);
            } else if (state is ShowArticleInCartState) {
              Map commands = cartC;
              return ListView.builder(
                  itemBuilder: ((context, index) {
                    final command = commands[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            "${command.price}BIF",
                            style: TextStyle(),
                          ),
                          leading: Text("${command.name}"),
                        )
                      ],
                    );
                  }),
                  itemCount: cartC.length);
            }

            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          totalInCart < 1
              ? null
              : Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                        appBar: AppBar(
                          title: const Text('EN ATTENTE'),
                        ),
                        body: Center(
                          child: ListView.builder(
                              itemBuilder: ((context, index) {
                                final command = cartC[index];
                                if (command != null) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title:
                                            Text("${command?.price ?? 0}BIF"),
                                        leading: Text("${command.name}"),
                                      )
                                    ],
                                  );
                                }
                                return const SizedBox();
                              }),
                              itemCount: cartC.length),
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            bloc.add(SaveCommandEvent(cartC));
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.money),
                            ],
                          ),
                        ));
                  },
                ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add_shopping_cart_rounded),
            Text("$totalInCart"),
          ],
        ),
      ),
    );
  }
}
