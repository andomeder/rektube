import 'package:drift/drift.dart';
import 'package:intl/intl.dart'; // Add intl package dependency

/// Handles conversion between PostgreSQL's `timestamp without time zone` (as String)
class TimestampNoTzConverter extends TypeConverter<DateTime, String> {
  const TimestampNoTzConverter();

  @override
  DateTime fromSql(String fromDb) {
    // PostgreSQL timestamp without time zone typically doesn't have 'Z' or offset
    // Try parsing common formats
    try {
       // Format like: 2023-10-27 10:30:00.123456
       return DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parseStrict(fromDb);
    } catch (_) {
       try {
         // Format without microseconds: 2023-10-27 10:30:00
         return DateFormat("yyyy-MM-dd HH:mm:ss").parseStrict(fromDb);
       } catch (e2) {
          print("!!! Error parsing timestamp string '$fromDb': $e2");
          throw FormatException("Could not parse timestamp from DB: $fromDb");
       }
    }
  }

  // toSql: Converts a Dart DateTime to a String for the DB
  @override
  String toSql(DateTime value) {
    // Format for PG timestamp without time zone
    return DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").format(value.toUtc()); // Store in UTC generally
  }
}

// ---- Add Nullable Version ----

class NullableTimestampNoTzConverter extends TypeConverter<DateTime?, String?> {
  const NullableTimestampNoTzConverter();

  @override
  DateTime? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    // Return non-nullable logic
    return const TimestampNoTzConverter().fromSql(fromDb);
  }

  @override
  String? toSql(DateTime? value) {
    if (value == null) return null;
    return const TimestampNoTzConverter().toSql(value);
  }
}