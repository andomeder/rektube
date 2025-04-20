// lib/database/type_converters.dart
import 'package:drift/drift.dart';
import 'package:intl/intl.dart'; // Add intl package dependency

/// Handles conversion between PostgreSQL's `timestamp without time zone` (as String)
/// and Dart's `DateTime` object.
/// Assumes the string format from PG is something like 'YYYY-MM-DD HH:MM:SS.ffffff'.
class TimestampNoTzConverter extends TypeConverter<DateTime, String> {
  const TimestampNoTzConverter();

  @override
  DateTime fromSql(String fromDb) {
    // PostgreSQL timestamp without time zone typically doesn't have 'Z' or offset
    // Try parsing common formats
    try {
       // Format like: 2023-10-27 10:30:00.123456
       return DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parseStrict(fromDb);
    } catch (e1) {
       try {
         // Format without microseconds: 2023-10-27 10:30:00
         return DateFormat("yyyy-MM-dd HH:mm:ss").parseStrict(fromDb);
       } catch (e2) {
          print("Error parsing timestamp string '$fromDb': $e1 / $e2");
          // Fallback or throw a more specific error
          // Returning epoch might hide errors, consider throwing
          // throw FormatException("Could not parse timestamp from DB: $fromDb");
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true); // Fallback
       }
    }
  }

  @override
  String toSql(DateTime value) {
    // Format DateTime for PostgreSQL insertion if needed (though defaults handle this)
    // This might not be strictly necessary if only reading/using DB defaults
    return DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").format(value);
  }
}