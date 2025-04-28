// lib/database/tables/playlist_items.dart
import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:rektube/database/tables/playlists.dart';
import 'package:rektube/database/type_converters.dart'; // Reference Playlists table

@DataClassName('PlaylistItem')
class PlaylistItems extends Table {
  @override
  String get tableName => 'playlist_items';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get playlistId => integer().named('playlist_id').references(Playlists, #id)();

  TextColumn get trackId => text().named('track_id')();

  TextColumn get trackTitle => text().named('track_title')();
  TextColumn get trackArtist => text().named('track_artist')();
  TextColumn get trackThumbnailPath => text().named('track_thumbnail_path').nullable()(); 
  IntColumn get trackDurationSeconds => integer().named('track_duration_seconds').nullable()();

  Column<PgDateTime> get addedAt => customType(PgTypes.timestampWithTimezone)
      .named('added_at')
      .clientDefault(() => PgDateTime(DateTime.now().toUtc()))
      .map(const PostgreSQLTimestampConverter())();

}