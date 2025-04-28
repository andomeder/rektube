// lib/database/daos/liked_song_dao.dart
import 'package:drift/drift.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/database/tables/liked_songs.dart';

part 'liked_song_dao.g.dart';

@DriftAccessor(tables: [LikedSongs])
class LikedSongDao extends DatabaseAccessor<AppDatabase> with _$LikedSongDaoMixin {
  LikedSongDao(super.db);

  // Get all liked songs for a user, ordered by liked date
  Stream<List<LikedSong>> watchLikedSongs(int userId) {
     return (select(likedSongs)
          ..where((song) => song.userId.equals(userId))
          ..orderBy([(song) => OrderingTerm(expression: song.likedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  // Check if a specific track is liked by a user
  Future<bool> isSongLiked(int userId, String trackId) async {
     final existing = await (select(likedSongs)
          ..where((song) => song.userId.equals(userId) & song.trackId.equals(trackId))
          ..limit(1))
        .getSingleOrNull();
     return existing != null;
  }

  // Like a song
  Future<int> likeSong(LikedSongsCompanion song) {
     // The unique constraint in the table definition handles duplicates
     return into(likedSongs).insert(song, mode: InsertMode.insertOrIgnore);
  }

  // Unlike a song
  Future<int> unlikeSong(int userId, String trackId) {
     return (delete(likedSongs)..where((song) => song.userId.equals(userId) & song.trackId.equals(trackId))).go();
  }
}