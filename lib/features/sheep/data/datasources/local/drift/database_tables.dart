part of 'database.dart';

class SheepTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phoneNumber => text()();
  BoolColumn get isWhatsAppNumber => boolean()();
  TextColumn get age => text()();
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

  // Since we already put int auto-increment column, it will be reconized as id
  // @override
  // Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {name, phoneNumber}
      ];
}

class SessionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sheepId => integer()();
  DateTimeColumn get appointmentDate => dateTime()();
  TextColumn get type => text()();
  IntColumn get sessionNumber => integer()();
  TextColumn get notes => text().nullable()();
  BoolColumn get completed => boolean()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  // Since we already put int auto-increment column, it will be reconized as id
  // @override
  // Set<Column> get primaryKey => {id};
}
