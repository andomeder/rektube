import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Converts between Postgres's `PgDateTime` wrapper and Dart's `DateTime`.
class PostgreSQLTimestampConverter
    extends TypeConverter<DateTime, PgDateTime?> {
  const PostgreSQLTimestampConverter();

  @override
  DateTime fromSql(PgDateTime? fromDb) {
    if (fromDb == null) {
      throw StateError('Unexpected null PgDateTime from DB');
    }
    // PgDateTime.dateTime is the actual Dart DateTime
    return fromDb.dateTime.toUtc();
  }

  @override
  PgDateTime? toSql(DateTime value) {
    // Wrap a UTC DateTime back into PgDateTime
    return PgDateTime(value.toUtc());
  }
}
