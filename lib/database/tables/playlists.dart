import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:rektube/database/tables/users.dart';
import 'package:rektube/database/type_converters.dart';

@DataClassName("Playlist")
class Playlists extends Table {
  @override
  String get tableName => "playlists";

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  IntColumn get userId => integer().named('user_id').references(Users, #id)();

  Column<PgDateTime> get createdAt => customType(PgTypes.timestampWithTimezone)
     .named('created_at')
     .clientDefault(() => PgDateTime(DateTime.now().toUtc()))
     .map(const PostgreSQLTimestampConverter())();

  TextColumn get thumbnail => text().nullable()();

}