// get_all_sheep_use_case.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sheep.dart';
import '../repositories/sheep_repository.dart';

class GetAllSheepUseCase implements UseCase<List<Sheep>, NoParams> {
  final SheepRepository repository;

  GetAllSheepUseCase(this.repository);

  @override
  Future<Either<Failure, List<Sheep>>> call(NoParams params) async {
    return await repository.getAllSheep();
  }
}
