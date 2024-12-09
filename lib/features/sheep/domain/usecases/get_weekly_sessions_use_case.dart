import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/session.dart';
import '../repositories/sheep_repository.dart';

class GetWeeklySessionsUseCase
    implements UseCase<List<Session>, GetWeeklySessionsParams> {
  final SheepRepository repository;

  GetWeeklySessionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Session>>> call(
    GetWeeklySessionsParams params,
  ) async {
    return await repository.getWeeklySessions(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetWeeklySessionsParams extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;

  const GetWeeklySessionsParams({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}
