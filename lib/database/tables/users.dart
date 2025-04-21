import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:rektube/database/type_converters.dart';

@DataClassName('User', extending: Table)
class Users extends Table {
  @override
  String get tableName => 'users';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  TextColumn get username => text().unique()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text().named('password_hash')();

  // Use the custom converter for DateTime fields
  //DateTimeColumn get createdAt => dateTime()
  //    .named('created_at')
  //    .withDefault(currentDateAndTime)
  //    .map(const PostgreSQLTimestampConverter())();

      
  //DateTimeColumn get updatedAt => dateTime()
  //    .named('updated_at')
  //    .withDefault(currentDateAndTime)
  //    .map(const PostgreSQLTimestampConverter())();

  Column<PgDateTime> get createdAt =>
      customType(PgTypes.timestampWithTimezone)
        .clientDefault(() => PgDateTime(DateTime.now().toUtc()))
        .map(const PostgreSQLTimestampConverter())();

  Column<PgDateTime> get updatedAt =>
      customType(PgTypes.timestampWithTimezone)
        .clientDefault(() => PgDateTime(DateTime.now().toUtc()))
        .map(const PostgreSQLTimestampConverter())();
}