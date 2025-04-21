// Provider for the main AppDatabase instance
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/database/daos/history_dao.dart';
import 'package:rektube/database/daos/liked_song_dao.dart';
import 'package:rektube/database/daos/playlist_dao.dart';
import 'package:rektube/database/daos/playlist_item_dao.dart';
import 'package:rektube/database/daos/user_dao.dart';
import 'package:rektube/database/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  // Return the singleton instance or create a new on
  return AppDatabase.instance;
});

//Provder for UserDao
final userDaoProvider = Provider<UserDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.userDao;
});

final playlistDaoProvider = Provider<PlaylistDao>((ref) => ref.watch(databaseProvider).playlistDao);
final playlistItemDaoProvider = Provider<PlaylistItemDao>((ref) => ref.watch(databaseProvider).playlistItemDao);
final likedSongDaoProvider = Provider<LikedSongDao>((ref) => ref.watch(databaseProvider).likedSongDao);
final historyDaoProvider = Provider<HistoryDao>((ref) => ref.watch(databaseProvider).historyDao);