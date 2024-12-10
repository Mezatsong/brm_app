import 'package:brm/core/usecases/usecase.dart';
import 'package:brm/features/sheep/domain/usecases/get_recent_sheep_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/sheep.dart';
import '../../../../domain/entities/sheep_dashboard_data.dart';
import '../../../../domain/usecases/get_dashboard_data_use_case.dart';

class SheepDashboardState {
  final SheepDashboardData? dashboardData;
  final List<Sheep>? recentSheep;
  final bool isLoading;
  final String? error;

  SheepDashboardState({
    this.dashboardData,
    this.recentSheep,
    this.isLoading = false,
    this.error,
  });

  SheepDashboardState copyWith({
    SheepDashboardData? dashboardData,
    List<Sheep>? recentSheep,
    bool? isLoading,
    String? error,
  }) {
    return SheepDashboardState(
      dashboardData: dashboardData ?? this.dashboardData,
      recentSheep: recentSheep ?? this.recentSheep,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class SheepDashboardCubit extends Cubit<SheepDashboardState> {
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final GetRecentSheepUseCase _getRecentSheepUseCase;

  SheepDashboardCubit(
    this._getDashboardDataUseCase,
    this._getRecentSheepUseCase,
  ) : super(SheepDashboardState(isLoading: true));

  Future<void> loadDashboardData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final dashboardDataResult = await _getDashboardDataUseCase.call(
        NoParams(),
      );
      final recentSheepsResult = await _getRecentSheepUseCase.call(
        GetRecentSheepParams(limit: 5),
      );

      dashboardDataResult.fold(
        (failure) => emit(state.copyWith(error: failure.toString())),
        (dashboardData) => emit(state.copyWith(dashboardData: dashboardData)),
      );

      recentSheepsResult.fold(
        (failure) => emit(state.copyWith(error: failure.toString())),
        (recentSheeps) => emit(state.copyWith(recentSheep: recentSheeps)),
      );

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
