import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:rektube/database/tables/users.dart';
import 'package:rektube/database/type_converters.dart';

@DataClassName('HistoryEntry')
class History extends Table {
  @override
  String get tableName => 'history';

  IntColumn get id => integer().autoIncrement()();
  // Foreign key to the user
  IntColumn get userId => integer().named('user_id').references(Users, #id)();
  // Piped track ID
  TextColumn get trackId => text().named('track_id')();
  // Store metadata
  TextColumn get trackTitle => text().named('track_title')();
  TextColumn get trackArtist => text().named('track_artist')();
  TextColumn get trackThumbnailPath => text().named('track_thumbnail_path').nullable()();
  IntColumn get trackDurationSeconds => integer().named('track_duration_seconds').nullable()();

  // Store the timestamp when it was played

  Column<PgDateTime> get playedAt =>
    customType(PgTypes.timestampWithTimezone)
      .named('played_at')
      .clientDefault(() => PgDateTime(DateTime.now().toUtc()))
      .map(const PostgreSQLTimestampConverter())();

   // Optional: Consider adding a constraint or logic to limit history size or
   // update playedAt if the same trackId is played again by the same user.
   // For simplicity now, it just logs every play.
}