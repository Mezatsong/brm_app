import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sheep.dart';
import '../repositories/sheep_repository.dart';

class AddSheepUseCase implements UseCase<void, AddSheepParams> {
  final SheepRepository repository;

  AddSheepUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddSheepParams params) async {
    return await repository.addSheep(params.sheep);
  }
}

class AddSheepParams extends Equatable {
  final Sheep sheep;

  const AddSheepParams({required this.sheep});

  @override
  List<Object> get props => [sheep];
}
