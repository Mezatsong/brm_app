import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/session.dart';
import '../repositories/sheep_repository.dart';

class GetSheepSessionsUseCase implements UseCase<List<Session>, SheepIdParams> {
  final SheepRepository repository;

  GetSheepSessionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Session>>> call(SheepIdParams params) async {
    return await repository.getSheepSessions(params.id);
  }
}

class SheepIdParams extends Equatable {
  final int id;

  const SheepIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
