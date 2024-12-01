import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sheep.dart';
import '../repositories/sheep_repository.dart';

class GetSheepByIdUseCase implements UseCase<Sheep, SheepIdParams> {
  final SheepRepository repository;

  GetSheepByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Sheep>> call(SheepIdParams params) async {
    return await repository.getSheepById(params.id);
  }
}

class SheepIdParams extends Equatable {
  final int id;

  const SheepIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
