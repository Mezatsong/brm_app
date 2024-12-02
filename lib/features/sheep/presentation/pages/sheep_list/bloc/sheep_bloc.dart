part of '../sheep_list_page.dart';

class _SheepBloc extends Bloc<_SheepEvent, _SheepState> {
  final SearchSheepWithFiltersUseCase _searchSheepWithFiltersUseCase;
  static const _pageSize = 25;

  _SheepBloc(this._searchSheepWithFiltersUseCase)
      : super(_SheepInitialState()) {
    on<_LoadSheepEvent>(_onLoadSheep);
    on<_SearchSheepEvent>(_onSearchSheep);
    on<_LoadMoreSheepEvent>(_onLoadMoreSheep);
  }

  Future<void> _onLoadSheep(
    _LoadSheepEvent event,
    Emitter<_SheepState> emit,
  ) async {
    try {
      emit(_SheepLoadingState());
      final result = await _searchSheepWithFiltersUseCase.call(
        SearchSheepWithFiltersUseCaseParams(limit: _pageSize),
      );

      result.fold(
        (failure) => emit(_SheepErrorState(failure.toString())),
        (sheep) => emit(_SheepLoadedState(
          sheep: sheep,
          hasReachedMax: sheep.length < _pageSize, // Assuming pagination
        )),
      );
    } catch (e) {
      emit(_SheepErrorState(e.toString()));
    }
  }

  Future<void> _onSearchSheep(
    _SearchSheepEvent event,
    Emitter<_SheepState> emit,
  ) async {
    try {
      emit(_SheepLoadingState());
      final result = await _searchSheepWithFiltersUseCase.call(
        SearchSheepWithFiltersUseCaseParams(
          query: event.query,
          status: event.status,
          stage: event.stage,
          surveyStatus: event.surveyStatus,
          limit: _pageSize,
        ),
      );

      result.fold(
        (failure) => emit(_SheepErrorState(failure.toString())),
        (sheep) => emit(_SheepLoadedState(
          sheep: sheep,
          hasReachedMax: sheep.length < _pageSize,
          // Conserve filters states
        )),
      );
    } catch (e) {
      emit(_SheepErrorState(e.toString()));
    }
  }

  Future<void> _onLoadMoreSheep(
    _LoadMoreSheepEvent event,
    Emitter<_SheepState> emit,
  ) async {
    if (state is _SheepLoadedState) {
      final currentState = state as _SheepLoadedState;

      if (currentState.hasReachedMax) return;

      try {
        final result = await _searchSheepWithFiltersUseCase.call(
          SearchSheepWithFiltersUseCaseParams(
            offset: currentState.sheep.length,
            limit: _pageSize,
            // Conserve filters states
            query: event.query,
            status: event.status,
            stage: event.stage,
            surveyStatus: event.surveyStatus,
          ),
        );

        result.fold(
          (failure) => emit(_SheepErrorState(failure.toString())),
          (moreSheep) => emit(_SheepLoadedState(
            sheep: [...currentState.sheep, ...moreSheep],
            hasReachedMax: moreSheep.length < _pageSize,
          )),
        );
      } catch (e) {
        emit(_SheepErrorState(e.toString()));
      }
    }
  }
}
