import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/enums/e_sheep_stage.dart';
import '../entities/enums/e_sheep_status.dart';
import '../entities/enums/e_sheep_survey_status.dart';
import '../entities/sheep.dart';
import '../entities/session.dart';

abstract class SheepRepository {
  Future<Either<Failure, List<Sheep>>> getAllSheep();

  Future<Either<Failure, List<Sheep>>> searchSheepWithFilters({
    required String query,
    ESheepStatus? status,
    ESheepStage? stage,
    ESheepSurveyStatus? surveyStatus,
    int? limit,
    int? offset,
  });

  Future<Either<Failure, List<Session>>> getWeeklySessions({
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, Sheep>> getSheepById(int id);

  Future<Either<Failure, void>> addSheep(Sheep sheep);

  Future<Either<Failure, void>> updateSheep(Sheep sheep);

  Future<Either<Failure, void>> abandonSheep({
    required int id,
    required String reason,
    required String details,
  });

  Future<Either<Failure, List<Session>>> getSheepSessions(int sheepId);

  Future<Either<Failure, void>> addSession(Session session);

  Future<Either<Failure, void>> updateSession(Session session);

  Future<Either<Failure, void>> exportToExcel(String path);

  Future<Either<Failure, void>> importFromExcel(Uint8List bytes);
}
