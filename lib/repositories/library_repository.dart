import 'package:drift/drift.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/database/daos/history_dao.dart';
import 'package:rektube/database/daos/liked_song_dao.dart';
import 'package:rektube/database/daos/playlist_dao.dart';
import 'package:rektube/database/daos/playlist_item_dao.dart';
import 'package:rektube/database/database.dart'; 
import 'package:rektube/models/track.dart' as model_track; 
import 'package:rektube/providers/database_providers.dart'; 
import 'package:rektube/utils/exceptions.dart';

class LibraryRepository {
  final Ref _ref;
  late final PlaylistDao _playlistDao = _ref.read(playlistDaoProvider);
  late final PlaylistItemDao _playlistItemDao = _ref.read(playlistItemDaoProvider);
  late final LikedSongDao _likedSongDao = _ref.read(likedSongDaoProvider);
  late final HistoryDao _historyDao = _ref.read(historyDaoProvider);

  LibraryRepository(this._ref);

  // Playlists 
  Stream<List<Playlist>> watchUserPlaylists(int userId) {
    try {
      return _playlistDao.watchUserPlaylists(userId);
    } catch (e) {
      print("Error getting playlists: $e");
      throw DatabaseException("Could not load playlists.");
    }
  }

  Future<Playlist> createPlaylist(int userId, String name) async {
    if (name.trim().isEmpty) {
      throw ArgumentError("Playlist name cannot be empty.");
    }
    final companion = PlaylistsCompanion.insert(
      name: name.trim(),
      userId: userId,
    );
    try {
      final newId = await _playlistDao.createPlaylist(companion);
      final newPlaylist = await (_playlistDao.select(_playlistDao.playlists)..where((p) => p.id.equals(newId))).getSingle();
      return newPlaylist;
    } catch (e) {
      print("Error creating playlist: $e");
      throw DatabaseException("Could not create playlist.");
    }
  }

  Future<void> deletePlaylist(int playlistId) async {
    try {
      await _playlistItemDao.removeAllTracksForPlaylist(playlistId);
      await _playlistDao.deletePlaylist(playlistId);
    } catch (e) {
       print("Error deleting playlist: $e");
       throw DatabaseException("Could not delete playlist.");
    }
  }

  Future<List<PlaylistItem>> getPlaylistItems(int playlistId) async {
     try {
        return await _playlistItemDao.getItemsForPlaylist(playlistId);
     } catch (e) {
        print("Error getting playlist items: $e");
        throw DatabaseException("Could not load playlist tracks.");
     }
  }

  Future<void> addTrackToPlaylist(int playlistId, model_track.Track track) async {
     final companion = PlaylistItemsCompanion.insert(
       playlistId: playlistId,
       trackId: track.id,
       trackTitle: track.title,
       trackArtist: track.artist,
       trackThumbnailPath: Value(track.thumbnailPath),
       trackDurationSeconds: Value(track.duration?.inSeconds),
     );
     try {
        await _playlistItemDao.addTrackToPlaylist(companion);
     } catch (e) {
        print("Error adding track to playlist: $e");
        throw DatabaseException("Could not add track to playlist.");
     }
  }

   Future<void> removeTrackFromPlaylist(int playlistItemId) async {
       try {
          await _playlistItemDao.removeTrackFromPlaylist(playlistItemId);
       } catch (e) {
          print("Error removing track from playlist: $e");
          throw DatabaseException("Could not remove track from playlist.");
       }
    }


  //  Liked Songs
   Stream<List<LikedSong>> watchLikedSongs(int userId) {
     try {
        return _likedSongDao.watchLikedSongs(userId);
     } catch (e) {
        print("Error getting liked songs: $e");
        throw DatabaseException("Could not load liked songs.");
     }
   }

   Future<bool> isLiked(int userId, String trackId) async {
      try {
        return await _likedSongDao.isSongLiked(userId, trackId);
      } catch (e) {
         print("Error checking if song is liked: $e");
         return false;
      }
   }

   Future<void> likeSong(int userId, model_track.Track track) async {
      final companion = LikedSongsCompanion.insert(
        userId: userId,
        trackId: track.id,
        trackTitle: track.title,
        trackArtist: track.artist,
        trackThumbnailPath: Value(track.thumbnailPath),
        trackDurationSeconds: Value(track.duration?.inSeconds),
      );
      try {
         await _likedSongDao.likeSong(companion);
      } catch (e) {
         print("Error liking song: $e");
         throw DatabaseException("Could not like song.");
      }
   }

   Future<void> unlikeSong(int userId, String trackId) async {
       try {
          await _likedSongDao.unlikeSong(userId, trackId);
       } catch (e) {
          print("Error unliking song: $e");
          throw DatabaseException("Could not unlike song.");
       }
   }

  // History 
  Stream<List<HistoryEntry>> watchHistory(int userId, {int limit = 50}) {
     try {
        return _historyDao.watchRecentHistory(userId, limit: limit);
     } catch (e) {
        print("Error getting history: $e");
        throw DatabaseException("Could not load history.");
     }
  }

  Future<void> logPlayback(int userId, model_track.Track track) async {
      final companion = HistoryCompanion.insert(
        userId: userId,
        trackId: track.id,
        trackTitle: track.title,
        trackArtist: track.artist,
        trackThumbnailPath: Value(track.thumbnailPath),
        trackDurationSeconds: Value(track.duration?.inSeconds),
        //playedAt: const Value.absent(),
      );
      try {
        await _historyDao.logPlayback(companion);
      } catch (e) {
         print("Error logging playback: $e");
         // throw DatabaseException("Could not log playback.");
      }
  }
}