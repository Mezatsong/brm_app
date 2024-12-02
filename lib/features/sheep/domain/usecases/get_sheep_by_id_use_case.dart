import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sheep.dart';
import '../repositories/sheep_repository.dart';

class GetSheepByIdUseCase implements UseCase<Sheep, int> {
  final SheepRepository repository;

  GetSheepByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Sheep>> call(int sheepId) async {
    return await repository.getSheepById(sheepId);
  }
}
