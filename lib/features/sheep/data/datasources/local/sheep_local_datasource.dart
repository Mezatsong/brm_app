import 'package:drift/drift.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/enums/e_sheep_stage.dart';
import '../../../domain/entities/enums/e_sheep_status.dart';
import '../../../domain/entities/enums/e_sheep_survey_status.dart';
import '../../models/sheep_model.dart';
import '../../models/session_model.dart';
import 'drift/database.dart';

abstract class SheepLocalDataSource {
  Future<List<SheepModel>> getAllSheep();

  Future<List<SheepModel>> searchSheepWithFilters(
    String query,
    ESheepStatus? status,
    ESheepStage? stage,
    ESheepSurveyStatus? surveyStatus,
    int? limit,
    int? offset,
  );

  Future<List<SessionModel>> getWeeklySessions(
      {DateTime? startDate, DateTime? endDate});

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
            ..orderBy([
              (s) => OrderingTerm.desc(s.createdAt),
            ]))
          .get();
      return sheepEntries.map(_convertToSheepModel).toList();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<List<SheepModel>> searchSheepWithFilters(
    String query,
    ESheepStatus? status,
    ESheepStage? stage,
    ESheepSurveyStatus? surveyStatus,
    int? limit,
    int? offset,
  ) async {
    try {
      final selectStmt = db.select(db.sheepTable).join([
        // Left join with sessions to get the last session
        leftOuterJoin(
          db.sessionTable,
          db.sessionTable.sheepId.equalsExp(db.sheepTable.id),
          useColumns: false,
        )
      ]);

      if (query.isNotEmpty) {
        // Filter by name (case-insensitive)
        selectStmt
            .where(db.sheepTable.name.lower().contains(query.toLowerCase()));
      }

      if (status != null) {
        // Filter by status (optional)
        selectStmt.where(db.sheepTable.status.equals(status.value));
      }

      if (stage != null) {
        // Filter by stage (optional)
        selectStmt.where(db.sheepTable.stage.equals(stage.value));
      }

      if (surveyStatus != null) {
        // Filter by survey status (optional)
        selectStmt.where(db.sheepTable.surveyStatus.equals(surveyStatus.value));
      }

      // if (limit != null) {
      //   selectStmt.limit(limit, offset: offset);
      // }

      // Maintain order by creation date descending
      // selectStmt.orderBy([(s) => OrderingTerm.desc(s.createdAt)]);

      // Order sessions by date to get the most recent
      selectStmt.orderBy([
        OrderingTerm.asc(db.sessionTable.completed),
        OrderingTerm.desc(db.sessionTable.appointmentDate,
            nulls: NullsOrder.last),
      ]);
      selectStmt.groupBy([db.sheepTable.id]);
      selectStmt.limit(1);

      // Transform results into Sheep objects with optional last session
      final results = await selectStmt.get();

      return results.map((row) {
        final sheepRow = row.readTable(db.sheepTable);
        final lastSessionRow = row.readTableOrNull(db.sessionTable);
        return _convertToSheepModel(sheepRow, lastSessionRow);
      }).toList();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<List<SessionModel>> getWeeklySessions({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // If no dates provided, default to current week
    final startAt = startDate ??
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    final endAt = endDate ?? startDate!.add(Duration(days: 6));

    final query = db.select(db.sessionTable).join([
      // Inner join to get sheep details for each session
      innerJoin(
          db.sheepTable, db.sheepTable.id.equalsExp(db.sessionTable.sheepId))
    ])
      // Filter by date range
      ..where(db.sessionTable.appointmentDate.isBetweenValues(startAt, endAt));

    // Transform results into Session objects with associated Sheep
    final results = await query.get();

    return results.map((row) {
      final sessionRow = row.readTable(db.sessionTable);
      final sheepRow = row.readTable(db.sheepTable);
      return _convertToSessionModel(sessionRow, sheepRow);
    }).toList();
  }

  @override
  Future<SheepModel> getSheepById(int id) async {
    try {
      final query = db.select(db.sheepTable).join([
        // Left join with sessions to get the last session
        leftOuterJoin(
          db.sessionTable,
          db.sessionTable.sheepId.equalsExp(db.sheepTable.id),
          useColumns: false,
        )
      ]);
      query.where(db.sheepTable.id.equals(id));

      final row = await query.getSingle();

      final sessionRow = row.readTable(db.sessionTable);
      final sheepRow = row.readTable(db.sheepTable);

      return _convertToSheepModel(sheepRow, sessionRow);
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
              type: session.type.value,
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

  SessionModel _convertToSessionModel(
    SessionTableData session, [
    SheepTableData? sheep,
  ]) {
    return SessionModel(
      id: session.id,
      sheepId: session.sheepId,
      appointmentDate: session.appointmentDate,
      type: ESheepStage.tryParse(session.type)!,
      sessionNumber: session.sessionNumber,
      notes: session.notes,
      completed: session.completed,
      completedAt: session.completedAt,
      sheepModel: sheep == null ? null : _convertToSheepModel(sheep),
    );
  }

  SheepModel _convertToSheepModel(
    SheepTableData sheep, [
    SessionTableData? lastSession,
  ]) {
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
      lastSessionModel:
          lastSession == null ? null : _convertToSessionModel(lastSession),
    );
  }
}
