// lib/database/daos/playlist_item_dao.dart
import 'package:drift/drift.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/database/tables/playlist_items.dart';

part 'playlist_item_dao.g.dart';

@DriftAccessor(tables: [PlaylistItems])
class PlaylistItemDao extends DatabaseAccessor<AppDatabase> with _$PlaylistItemDaoMixin {
  PlaylistItemDao(super.db);

  // Get all items for a specific playlist, ordered by add date
  Future<List<PlaylistItem>> getItemsForPlaylist(int playlistId) {
    return (select(playlistItems)
          ..where((item) => item.playlistId.equals(playlistId))
          ..orderBy([(item) => OrderingTerm(expression: item.addedAt, mode: OrderingMode.asc)]) // Example order
          )
        .get();
  }

  // Add a track to a playlist
  Future<int> addTrackToPlaylist(PlaylistItemsCompanion item) {
     // Consider checking if item already exists first if needed
    return into(playlistItems).insert(item);
  }

  // Remove a track from a playlist (using the playlist item ID)
  Future<int> removeTrackFromPlaylist(int playlistItemId) {
    return (delete(playlistItems)..where((item) => item.id.equals(playlistItemId))).go();
  }

   // Remove all items for a given playlist ID (useful when deleting a playlist)
   Future<int> removeAllTracksForPlaylist(int playlistId) {
     return (delete(playlistItems)..where((item) => item.playlistId.equals(playlistId))).go();
   }
}