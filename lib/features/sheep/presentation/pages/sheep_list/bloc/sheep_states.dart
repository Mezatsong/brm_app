part of '../sheep_list_page.dart';

abstract class _SheepState {}

class _SheepInitialState extends _SheepState {}

class _SheepLoadingState extends _SheepState {}

class _SheepLoadedState extends _SheepState {
  final List<Sheep> sheep;
  final bool hasReachedMax;

  _SheepLoadedState({
    required this.sheep,
    required this.hasReachedMax,
  });
}

class _SheepErrorState extends _SheepState {
  final String message;

  _SheepErrorState(this.message);
}
