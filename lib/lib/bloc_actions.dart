import 'package:flutter/foundation.dart' show immutable;
import 'package:store/lib/person.dart';

const personUrl1 = 'http://localhost:5500/api/person1.json';
const personUrl2 = 'http://localhost:5500/api/person2.json';

typedef PersonsLoader = Future<Iterable<Person> Function(String url);


@immutable
abstract class LocalAction {
  const LocalAction();
}

@immutable
class LoadActionPerson implements LocalAction {
  final String url;
  const LoadActionPerson({required this.url}) : super();
}

// enum PersonUrl { person1, person2 }

// extension UrlString on PersonUrl {
//   String get urlString {
//     switch (this) {
//       case PersonUrl.person1:
//         return 'http://localhost:5500/api/person1.json';
//       case PersonUrl.person2:
//         return 'http://localhost:5500/api/person2.json';
//     }
//   }
// }
