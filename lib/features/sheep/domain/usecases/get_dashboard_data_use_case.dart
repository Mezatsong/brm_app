import 'package:brm/core/error/failures.dart';
import 'package:brm/core/usecases/usecase.dart';
import 'package:brm/features/sheep/domain/entities/sheep_dashboard_data.dart';
import 'package:dartz/dartz.dart';

import '../repositories/sheep_repository.dart';

class GetDashboardDataUseCase extends UseCase<SheepDashboardData, NoParams> {
  final SheepRepository _repository;

  GetDashboardDataUseCase(this._repository);

  @override
  Future<Either<Failure, SheepDashboardData>> call(params) async {
    return await _repository.getDashboardData();
  }
}
