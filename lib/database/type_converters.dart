import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

class PostgreSQLTimestampConverter
    extends TypeConverter<DateTime, PgDateTime?> {
  const PostgreSQLTimestampConverter();

  @override
  DateTime fromSql(PgDateTime? fromDb) {
    if (fromDb == null) {
      throw StateError('Unexpected null PgDateTime from DB');
    }
    return fromDb.dateTime.toUtc();
  }

  @override
  PgDateTime? toSql(DateTime value) {
    return PgDateTime(value.toUtc());
  }
}
