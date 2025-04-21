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
  // Foreign key to the playlist
  IntColumn get playlistId => integer().named('playlist_id').references(Playlists, #id)();
  // Store the Piped track ID (videoId)
  TextColumn get trackId => text().named('track_id')();
  // Store track metadata directly here to avoid needing Piped API calls just to display playlist contents
  TextColumn get trackTitle => text().named('track_title')();
  TextColumn get trackArtist => text().named('track_artist')();
  TextColumn get trackThumbnailUrl => text().named('track_thumbnail_url').nullable()(); // Nullable
  IntColumn get trackDurationSeconds => integer().named('track_duration_seconds').nullable()(); // Nullable duration in seconds

  Column<PgDateTime> get addedAt => customType(PgTypes.timestampWithTimezone)
      .named('added_at')
      .map(const PostgreSQLTimestampConverter())();

  // Optional: Add an order column if you want user-defined playlist order
  // IntColumn get itemOrder => integer().named('item_order').nullable()();
}