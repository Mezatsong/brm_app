import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/sheep.dart';
import '../entities/session.dart';

abstract class SheepRepository {
  Future<Either<Failure, List<Sheep>>> getAllSheep();
  Future<Either<Failure, Sheep>> getSheepById(String id);
  Future<Either<Failure, void>> addSheep(Sheep sheep);
  Future<Either<Failure, void>> updateSheep(Sheep sheep);
  Future<Either<Failure, void>> abandonSheep(String id, String reason, String details);
  Future<Either<Failure, List<Session>>> getSheepSessions(String sheepId);
  Future<Either<Failure, void>> addSession(Session session);
  Future<Either<Failure, void>> updateSession(Session session);
  Future<Either<Failure, void>> exportToExcel(String path);
  Future<Either<Failure, void>> importFromExcel(String path);
}