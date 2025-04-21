import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:rektube/database/tables/users.dart';
import 'package:rektube/database/type_converters.dart';

@DataClassName('LikedSong')
class LikedSongs extends Table {
  @override
  String get tableName => 'liked_songs';

  IntColumn get id => integer().autoIncrement()();
  // Foreign key to the user who liked the song
  IntColumn get userId => integer().named('user_id').references(Users, #id)();
  // Piped track ID
  TextColumn get trackId => text().named('track_id')();
   // Store metadata for easier display
  TextColumn get trackTitle => text().named('track_title')();
  TextColumn get trackArtist => text().named('track_artist')();
  TextColumn get trackThumbnailUrl => text().named('track_thumbnail_url').nullable()();
  IntColumn get trackDurationSeconds => integer().named('track_duration_seconds').nullable()();

  Column<PgDateTime> get likedAt => customType(PgTypes.timestampWithTimezone)
     .named('liked_at')
     .map(const PostgreSQLTimestampConverter())();

  // Add a unique constraint to prevent liking the same song multiple times per user
  @override
  List<String> get customConstraints => ['UNIQUE(user_id, track_id)'];
}