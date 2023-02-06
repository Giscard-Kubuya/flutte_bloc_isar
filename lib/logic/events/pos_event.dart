import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class PosEvent {}

class SetCommandEvent implements PosEvent {}

class ShowArticleInCartEvent implements PosEvent {}

class SaveCommandEvent implements PosEvent {
  final Map commandes;
  SaveCommandEvent(this.commandes);
}

class FechtDetailsCommandEvent implements PosEvent {
  final String code;
  FechtDetailsCommandEvent(this.code);
}

class InitCommandEvent implements PosEvent {}
