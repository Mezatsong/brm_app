import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/sheep.dart';
import '../../domain/repositories/sheep_repository.dart';

part 'sheep_list_state.dart';

class SheepListCubit extends Cubit<SheepListState> {
  final SheepRepository repository;

  SheepListCubit(this.repository) : super(const SheepListState());

  Future<void> loadSheep() async {
    emit(state.copyWith(status: SheepListStatus.loading));

    final result = await repository.getAllSheep();
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: SheepListStatus.error,
        error: failure.message,
      )),
      (sheep) => emit(state.copyWith(
        status: SheepListStatus.success,
        sheep: sheep,
      )),
    );
  }

  void filterSheep(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredSheep: null));
      return;
    }

    final filtered = state.sheep.where((sheep) {
      final searchStr = query.toLowerCase();
      return sheep.name.toLowerCase().contains(searchStr) ||
             sheep.phoneNumber.contains(searchStr);
    }).toList();

    emit(state.copyWith(filteredSheep: filtered));
  }
}