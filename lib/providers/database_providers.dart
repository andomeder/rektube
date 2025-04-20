// Provider for the main AppDatabase instance
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

