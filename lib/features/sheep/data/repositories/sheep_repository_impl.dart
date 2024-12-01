import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/sheep.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/sheep_repository.dart';
import '../datasources/local/sheep_local_datasource.dart';
import '../models/sheep_model.dart';
import '../models/session_model.dart';

class SheepRepositoryImpl implements SheepRepository {
  final SheepLocalDataSource localDataSource;

  SheepRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Sheep>>> getAllSheep() async {
    try {
      final sheep = await localDataSource.getAllSheep();
      return Right(sheep);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Sheep>> getSheepById(String id) async {
    try {
      final sheep = await localDataSource.getSheepById(id);
      return Right(sheep);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addSheep(Sheep sheep) async {
    try {
      await localDataSource.addSheep(sheep as SheepModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSheep(Sheep sheep) async {
    try {
      await localDataSource.updateSheep(sheep as SheepModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> abandonSheep(
    String id,
    String reason,
    String details,
  ) async {
    try {
      await localDataSource.abandonSheep(id, reason, details);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Session>>> getSheepSessions(String sheepId) async {
    try {
      final sessions = await localDataSource.getSheepSessions(sheepId);
      return Right(sessions);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addSession(Session session) async {
    try {
      await localDataSource.addSession(session as SessionModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSession(Session session) async {
    try {
      await localDataSource.updateSession(session as SessionModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> exportToExcel(String path) async {
    try {
      final sheep = await localDataSource.getAllSheep();
      final excel = Excel.createExcel();
      
      final sheet = excel['Sheep'];
      
      // Add headers
      final headers = [
        'ID',
        'Name',
        'Phone',
        'WhatsApp',
        'Age',
        'Address',
        'Provider Name',
        'Provider Phone',
        'Relation',
        'Finder Name',
        'Finder Phone',
        'Created At',
        'Status',
        'Stage',
        'Survey Status',
        'Total Sessions',
        'Sessions Done',
        'Watering Done',
        'Abandon Reason',
        'Abandon Details'
      ];
      
      sheet.insertRowIterables(headers.map(TextCellValue.new).toList(), 0);
      
      // Add data
      for (var i = 0; i < sheep.length; i++) {
        final s = sheep[i];
        sheet.insertRowIterables([
          TextCellValue(s.id),
          TextCellValue(s.name),
          TextCellValue(s.phoneNumber),
          TextCellValue(s.whatsappNumber ?? ''),
          IntCellValue(s.age),
          TextCellValue(s.address),
          TextCellValue(s.providerName),
          TextCellValue(s.providerPhone),
          TextCellValue(s.relationWithProvider),
          TextCellValue(s.finderName),
          TextCellValue(s.finderPhone),
          DateTimeCellValue.fromDateTime(s.createdAt),
          TextCellValue(s.status),
          TextCellValue(s.stage),
          TextCellValue(s.surveyStatus),
          IntCellValue(s.totalSessions),
          IntCellValue(s.sessionsDone),
          IntCellValue(s.wateringSessionsDone),
          TextCellValue(s.abandonReason ?? ''),
          TextCellValue(s.abandonDetails ?? ''),
        ], i + 1);
      }
      
      final file = File(path);
      await file.writeAsBytes(excel.encode()!);
      
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> importFromExcel(String path) async {
    try {
      final bytes = File(path).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);
      
      final sheet = excel.tables['Sheep'];
      if (sheet == null) {
        return Left(ValidationFailure('Invalid Excel file format'));
      }
      
      // Skip header row
      for (var row in sheet.rows.skip(1)) {
        if (row.isEmpty) continue;
        
        final sheep = SheepModel(
          id: row[0]?.value.toString() ?? '',
          name: row[1]?.value.toString() ?? '',
          phoneNumber: row[2]?.value.toString() ?? '',
          whatsappNumber: row[3]?.value.toString(),
          age: int.tryParse(row[4]?.value.toString() ?? '') ?? 0,
          address: row[5]?.value.toString() ?? '',
          providerName: row[6]?.value.toString() ?? '',
          providerPhone: row[7]?.value.toString() ?? '',
          relationWithProvider: row[8]?.value.toString() ?? '',
          finderName: row[9]?.value.toString() ?? '',
          finderPhone: row[10]?.value.toString() ?? '',
          createdAt: DateTime.parse(row[11]?.value.toString() ?? ''),
          status: row[12]?.value.toString() ?? '',
          stage: row[13]?.value.toString() ?? '',
          surveyStatus: row[14]?.value.toString() ?? '',
          totalSessions: int.tryParse(row[15]?.value.toString() ?? '') ?? 8,
          sessionsDone: int.tryParse(row[16]?.value.toString() ?? '') ?? 0,
          wateringSessionsDone: int.tryParse(row[17]?.value.toString() ?? '') ?? 0,
          abandonReason: row[18]?.value.toString(),
          abandonDetails: row[19]?.value.toString(),
        );
        
        await localDataSource.addSheep(sheep);
      }
      
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}