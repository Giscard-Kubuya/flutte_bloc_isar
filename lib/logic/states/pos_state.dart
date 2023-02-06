import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class PosState {}

class SetCommandState implements PosState {
  final List articles;
  SetCommandState(this.articles);
}

class ShowArticleInCartState implements PosState {}

class InitCommandState implements PosState {
  final List commands;
  InitCommandState(this.commands);
}

class FechtDetailsCommandState implements PosState {
  final List detailsCommand;
  FechtDetailsCommandState(this.detailsCommand);
}
