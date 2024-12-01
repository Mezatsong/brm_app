import 'package:drift/drift.dart';

import 'construct_db/construct_db.dart'
  if (dart.library.ffi) 'construct_db/construct_db_native.dart'
  if (dart.library.html) 'construct_db/construct_db_web.dart';

part 'database_tables.dart';
part 'database.g.dart';


@DriftDatabase(tables: [SheepTable, SessionTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(constructDb());

  @override
  int get schemaVersion => 1;
}
