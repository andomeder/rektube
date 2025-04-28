// lib/database/daos/playlist_dao.dart
import 'package:drift/drift.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/database/tables/playlists.dart';

part 'playlist_dao.g.dart';

@DriftAccessor(tables: [Playlists])
class PlaylistDao extends DatabaseAccessor<AppDatabase> with _$PlaylistDaoMixin {
  PlaylistDao(super.db);

  // Get all playlists for a specific user
  Stream<List<Playlist>> watchUserPlaylists(int userId) {
    return (select(playlists)..where((p) => p.userId.equals(userId)))
        .watch();
  }

  // Create a new playlist
  Future<int> createPlaylist(PlaylistsCompanion playlist) {
    return into(playlists).insert(playlist); // Returns new playlist ID
  }

  // Delete a playlist 
  Future<int> deletePlaylist(int playlistId) {
     return (delete(playlists)..where((p) => p.id.equals(playlistId))).go();
  }

  // TODO: Add methods to update playlist name/details
}