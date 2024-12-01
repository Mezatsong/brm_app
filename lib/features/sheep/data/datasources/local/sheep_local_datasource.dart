import 'package:drift/drift.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/sheep.dart';
import '../../models/sheep_model.dart';
import '../../models/session_model.dart';
import 'drift/database.dart';

abstract class SheepLocalDataSource {
  Future<List<SheepModel>> getAllSheep();
  Future<SheepModel> getSheepById(int id);
  Future<void> addSheep(SheepModel sheep);
  Future<void> updateSheep(SheepModel sheep);
  Future<void> abandonSheep(int id, String reason, String details);
  Future<List<SessionModel>> getSheepSessions(int sheepId);
  Future<void> addSession(SessionModel session);
  Future<void> updateSession(SessionModel session);
}

class SheepLocalDataSourceImpl implements SheepLocalDataSource {
  final MyDatabase db;

  SheepLocalDataSourceImpl(this.db);

  @override
  Future<List<SheepModel>> getAllSheep() async {
    try {
      final sheepEntries = await (db.select(db.sheepTable)
            ..orderBy([(s) => OrderingTerm.desc(s.createdAt)]))
          .get();
      return sheepEntries.map((sheep) => _convertToSheepModel(sheep)).toList();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<SheepModel> getSheepById(int id) async {
    try {
      final sheep = await (db.select(db.sheepTable)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
      return _convertToSheepModel(sheep);
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> addSheep(SheepModel sheep) async {
    try {
      await db.into(db.sheepTable).insert(
            SheepTableCompanion.insert(
              name: sheep.name,
              phoneNumber: sheep.phoneNumber,
              isWhatsAppNumber: sheep.isWhatsAppNumber,
              age: sheep.age,
              address: sheep.address,
              providerName: sheep.providerName,
              providerPhone: sheep.providerPhone,
              relationWithProvider: sheep.relationWithProvider,
              finderName: sheep.finderName,
              finderPhone: sheep.finderPhone,
              createdAt: sheep.createdAt,
              status: sheep.status.value,
              stage: sheep.stage.value,
              surveyStatus: sheep.surveyStatus.value,
              totalSessions: sheep.totalSessions,
              sessionsDone: sheep.sessionsDone,
              wateringSessionsDone: sheep.wateringSessionsDone,
              abandonReason: Value(sheep.abandonReason),
              abandonDetails: Value(sheep.abandonDetails),
            ),
          );
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> updateSheep(SheepModel sheep) async {
    try {
      await (db.update(db.sheepTable)..where((tbl) => tbl.id.equals(sheep.id)))
          .write(
        SheepTableCompanion(
          name: Value(sheep.name),
          phoneNumber: Value(sheep.phoneNumber),
          isWhatsAppNumber: Value(sheep.isWhatsAppNumber),
          age: Value(sheep.age),
          address: Value(sheep.address),
          providerName: Value(sheep.providerName),
          providerPhone: Value(sheep.providerPhone),
          relationWithProvider: Value(sheep.relationWithProvider),
          finderName: Value(sheep.finderName),
          finderPhone: Value(sheep.finderPhone),
          status: Value(sheep.status.value),
          stage: Value(sheep.stage.value),
          surveyStatus: Value(sheep.surveyStatus.value),
          totalSessions: Value(sheep.totalSessions),
          sessionsDone: Value(sheep.sessionsDone),
          wateringSessionsDone: Value(sheep.wateringSessionsDone),
          abandonReason: Value(sheep.abandonReason),
          abandonDetails: Value(sheep.abandonDetails),
        ),
      );
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> abandonSheep(int id, String reason, String details) async {
    try {
      await (db.update(db.sheepTable)..where((tbl) => tbl.id.equals(id))).write(
        SheepTableCompanion(
          status: const Value('abandoned'),
          abandonReason: Value(reason),
          abandonDetails: Value(details),
        ),
      );
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<List<SessionModel>> getSheepSessions(int sheepId) async {
    try {
      final sessions = await (db.select(db.sessionTable)
            ..where((tbl) => tbl.sheepId.equals(sheepId)))
          .get();
      return sessions
          .map((session) => _convertToSessionModel(session))
          .toList();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> addSession(SessionModel session) async {
    try {
      await db.into(db.sessionTable).insert(
            SessionTableCompanion.insert(
              sheepId: session.sheepId,
              appointmentDate: session.appointmentDate,
              type: session.type,
              sessionNumber: session.sessionNumber,
              notes: Value(session.notes),
              completed: session.completed,
              completedAt: Value(session.completedAt),
            ),
          );
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> updateSession(SessionModel session) async {
    try {
      await (db.update(db.sessionTable)
            ..where((tbl) => tbl.id.equals(session.id)))
          .write(
        SessionTableCompanion(
          appointmentDate: Value(session.appointmentDate),
          notes: Value(session.notes),
          completed: Value(session.completed),
          completedAt: Value(session.completedAt),
        ),
      );
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  SheepModel _convertToSheepModel(SheepTableData sheep) {
    return SheepModel(
      id: sheep.id,
      name: sheep.name,
      phoneNumber: sheep.phoneNumber,
      isWhatsAppNumber: sheep.isWhatsAppNumber,
      age: sheep.age,
      address: sheep.address,
      providerName: sheep.providerName,
      providerPhone: sheep.providerPhone,
      relationWithProvider: sheep.relationWithProvider,
      finderName: sheep.finderName,
      finderPhone: sheep.finderPhone,
      createdAt: sheep.createdAt,
      status: ESheepStatus.tryParse(sheep.status)!,
      stage: ESheepStage.tryParse(sheep.stage)!,
      surveyStatus: ESheepSurveyStatus.tryParse(sheep.surveyStatus)!,
      totalSessions: sheep.totalSessions,
      sessionsDone: sheep.sessionsDone,
      wateringSessionsDone: sheep.wateringSessionsDone,
      abandonReason: sheep.abandonReason,
      abandonDetails: sheep.abandonDetails,
    );
  }

  SessionModel _convertToSessionModel(SessionTableData session) {
    return SessionModel(
      id: session.id,
      sheepId: session.sheepId,
      appointmentDate: session.appointmentDate,
      type: session.type,
      sessionNumber: session.sessionNumber,
      notes: session.notes,
      completed: session.completed,
      completedAt: session.completedAt,
    );
  }
}
