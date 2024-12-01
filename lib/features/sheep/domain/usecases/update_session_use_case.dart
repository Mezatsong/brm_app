import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/session.dart';
import '../repositories/sheep_repository.dart';

class UpdateSessionUseCase implements UseCase<void, UpdateSessionParams> {
  final SheepRepository repository;

  UpdateSessionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateSessionParams params) async {
    return await repository.updateSession(params.session);
  }
}

class UpdateSessionParams extends Equatable {
  final Session session;

  const UpdateSessionParams({required this.session});

  @override
  List<Object> get props => [session];
}
