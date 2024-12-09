import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/enums/e_sheep_stage.dart';
import '../entities/enums/e_sheep_status.dart';
import '../entities/enums/e_sheep_survey_status.dart';
import '../entities/sheep.dart';
import '../repositories/sheep_repository.dart';

class SearchSheepWithFiltersUseCase
    implements UseCase<List<Sheep>, SearchSheepWithFiltersUseCaseParams> {
  final SheepRepository repository;

  SearchSheepWithFiltersUseCase(this.repository);

  @override
  Future<Either<Failure, List<Sheep>>> call(
    SearchSheepWithFiltersUseCaseParams params,
  ) async {
    return await repository.searchSheepWithFilters(
      query: params.query,
      status: params.status,
      stage: params.stage,
      surveyStatus: params.surveyStatus,
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class SearchSheepWithFiltersUseCaseParams extends Equatable {
  final String query;
  final ESheepStatus? status;
  final ESheepStage? stage;
  final ESheepSurveyStatus? surveyStatus;
  final int? limit;
  final int? offset;

  const SearchSheepWithFiltersUseCaseParams({
    this.query = '',
    this.status,
    this.stage,
    this.surveyStatus,
    this.limit,
    this.offset,
  });

  @override
  List<Object?> get props => [query, status, stage, surveyStatus];
}
