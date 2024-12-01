import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sheep.dart';
import '../repositories/sheep_repository.dart';

class UpdateSheepUseCase implements UseCase<void, UpdateSheepParams> {
  final SheepRepository repository;

  UpdateSheepUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateSheepParams params) async {
    return await repository.updateSheep(params.sheep);
  }
}

class UpdateSheepParams extends Equatable {
  final Sheep sheep;

  const UpdateSheepParams({required this.sheep});

  @override
  List<Object> get props => [sheep];
}
