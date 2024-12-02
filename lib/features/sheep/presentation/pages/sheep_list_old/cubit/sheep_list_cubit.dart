import 'package:brm/core/usecases/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/sheep.dart';
import '../../../../domain/usecases/get_all_sheep_use_case.dart';

part 'sheep_list_state.dart';

class SheepListCubit extends Cubit<SheepListState> {
  final GetAllSheepUseCase _getAllSheepUseCase;

  SheepListCubit(this._getAllSheepUseCase) : super(const SheepListState());

  Future<void> loadSheep() async {
    emit(state.copyWith(status: SheepListStatus.loading));

    final result = await _getAllSheepUseCase.call(NoParams());

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
