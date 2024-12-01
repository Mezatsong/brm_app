import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/session.dart';
import '../repositories/sheep_repository.dart';

class AddSessionUseCase implements UseCase<void, AddSessionParams> {
  final SheepRepository repository;

  AddSessionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddSessionParams params) async {
    return await repository.addSession(params.session);
  }
}

class AddSessionParams extends Equatable {
  final Session session;

  const AddSessionParams({required this.session});

  @override
  List<Object> get props => [session];
}
