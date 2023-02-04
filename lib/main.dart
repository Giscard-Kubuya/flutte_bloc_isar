import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Flutter Cubit",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => PersonBloc(),
        child: const MyHomePage(),
      ),
    ),
  );
}

@immutable
abstract class LocalAction {
  const LocalAction();
}

enum PersonUrl { person1, person2 }

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://localhost:5500/api/person1.json';
      case PersonUrl.person2:
        return 'http://localhost:5500/api/person2.json';
    }
  }
}

@immutable
class LoadActionPerson implements LocalAction {
  final PersonUrl url;
  const LoadActionPerson({required this.url}) : super();
}

@immutable
class Person {
  final String name;
  final int age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        age = json["age"] as int;
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List)
    .then((list) => list.map((e) => Person.fromJson(e)));

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrieveFromCache;
  const FetchResult({required this.persons, required this.isRetrieveFromCache});

  @override
  String toString() =>
      'FetchResult(isRetrieveFromCache=$isRetrieveFromCache),persons:$persons';
}

class PersonBloc extends Bloc<LocalAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    on<LoadActionPerson>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final personsCache = _cache[url]!;
        final result =
            FetchResult(persons: personsCache, isRetrieveFromCache: true);
        emit(result);
      } else {
        final persons = await getPersons(url.urlString);
        _cache[url] = persons;
        final result =
            FetchResult(persons: persons, isRetrieveFromCache: false);
        emit(result);
      }
    });
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My home page'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    context
                        .read<PersonBloc>()
                        .add(const LoadActionPerson(url: PersonUrl.person1));
                  },
                  child: const Text('Load json #1'),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<PersonBloc>()
                        .add(const LoadActionPerson(url: PersonUrl.person2));
                  },
                  child: const Text('Load json #2'),
                ),
              ],
            ),
            BlocBuilder<PersonBloc, FetchResult?>(
                buildWhen: (previousResult, currentResult) {
              return previousResult?.persons != currentResult?.persons;
            }, builder: ((context, fetchResult) {
              final persons = fetchResult?.persons;
              if (persons == null) {
                return const SizedBox();
              }
              return Expanded(
                  child: ListView.builder(
                itemBuilder: ((context, index) {
                  final person = persons[index]!;
                  return ListTile(
                    title: Text(person.name),
                  );
                }),
                itemCount: persons.length,
              ));
            }))
          ],
        ));
  }
}
