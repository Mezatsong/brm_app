part of 'sheep_list_cubit.dart';

enum SheepListStatus { initial, loading, success, error }

class SheepListState extends Equatable {
  final SheepListStatus status;
  final List<Sheep> sheep;
  final List<Sheep>? filteredSheep;
  final String? error;

  const SheepListState({
    this.status = SheepListStatus.initial,
    this.sheep = const [],
    this.filteredSheep,
    this.error,
  });

  List<Sheep> get displaySheep => filteredSheep ?? sheep;

  SheepListState copyWith({
    SheepListStatus? status,
    List<Sheep>? sheep,
    List<Sheep>? filteredSheep,
    String? error,
  }) {
    return SheepListState(
      status: status ?? this.status,
      sheep: sheep ?? this.sheep,
      filteredSheep: filteredSheep,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, sheep, filteredSheep, error];
}