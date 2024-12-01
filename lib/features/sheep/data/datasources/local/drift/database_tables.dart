part of 'database.dart';

class SheepTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get whatsappNumber => text().nullable()();
  IntColumn get age => integer()();
  TextColumn get address => text()();
  TextColumn get providerName => text()();
  TextColumn get providerPhone => text()();
  TextColumn get relationWithProvider => text()();
  TextColumn get finderName => text()();
  TextColumn get finderPhone => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get status => text()();
  TextColumn get stage => text()();
  TextColumn get surveyStatus => text()();
  IntColumn get totalSessions => integer()();
  IntColumn get sessionsDone => integer()();
  IntColumn get wateringSessionsDone => integer()();
  TextColumn get abandonReason => text().nullable()();
  TextColumn get abandonDetails => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SessionTable extends Table {
  TextColumn get id => text()();
  TextColumn get sheepId => text()();
  DateTimeColumn get appointmentDate => dateTime()();
  TextColumn get type => text()();
  IntColumn get sessionNumber => integer()();
  TextColumn get notes => text().nullable()();
  BoolColumn get completed => boolean()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

