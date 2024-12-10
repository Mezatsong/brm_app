import 'package:brm/core/error/failures.dart';
import 'package:brm/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/sheep_model.dart';
import '../repositories/sheep_repository.dart';

class GetRecentSheepUseCase
    extends UseCase<List<SheepModel>, GetRecentSheepParams> {
  final SheepRepository _repository;

  GetRecentSheepUseCase(this._repository);

  @override
  Future<Either<Failure, List<SheepModel>>> call(params) async {
    return await _repository.getRecentSheeps(params.limit);
  }
}

class GetRecentSheepParams extends Equatable {
  final int limit;

  const GetRecentSheepParams({required this.limit});

  @override
  List<Object> get props => [limit];
}
