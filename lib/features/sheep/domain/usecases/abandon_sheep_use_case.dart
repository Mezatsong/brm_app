import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/sheep_repository.dart';

class AbandonSheepUseCase implements UseCase<void, AbandonSheepParams> {
  final SheepRepository repository;

  AbandonSheepUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AbandonSheepParams params) async {
    return await repository.abandonSheep(
        params.id, params.reason, params.details);
  }
}

class AbandonSheepParams extends Equatable {
  final int id;
  final String reason;
  final String details;

  const AbandonSheepParams({
    required this.id,
    required this.reason,
    required this.details,
  });

  @override
  List<Object> get props => [id, reason, details];
}
