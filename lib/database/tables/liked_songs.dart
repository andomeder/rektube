import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:rektube/database/tables/users.dart';
import 'package:rektube/database/type_converters.dart';

@DataClassName('LikedSong')
class LikedSongs extends Table {
  @override
  String get tableName => 'liked_songs';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().named('user_id').references(Users, #id)();

  TextColumn get trackId => text().named('track_id')();

  TextColumn get trackTitle => text().named('track_title')();
  TextColumn get trackArtist => text().named('track_artist')();
  TextColumn get trackThumbnailPath => text().named('track_thumbnail_path').nullable()();
  IntColumn get trackDurationSeconds => integer().named('track_duration_seconds').nullable()();

  Column<PgDateTime> get likedAt => customType(PgTypes.timestampWithTimezone)
     .named('liked_at')
     .clientDefault(() => PgDateTime(DateTime.now().toUtc()))
     .map(const PostgreSQLTimestampConverter())();


  @override
  List<String> get customConstraints => ['UNIQUE(user_id, track_id)'];
}