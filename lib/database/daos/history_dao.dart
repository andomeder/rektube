// lib/database/daos/history_dao.dart
import 'package:drift/drift.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/database/tables/history.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: [History])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  // Get recent history for a user, ordered by most recent first
  // Use distinctOn or subqueries later if you only want unique track IDs
  Future<List<HistoryEntry>> getRecentHistory(int userId, {int limit = 50}) {
    return (select(history)
          ..where((entry) => entry.userId.equals(userId))
          ..orderBy([(entry) => OrderingTerm(expression: entry.playedAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  // Add an entry to history
  Future<int> logPlayback(HistoryCompanion entry) {
     // Simple insert for now.
     // Advanced: Could update playedAt if trackId exists recently for userId.
     return into(history).insert(entry);
  }

  // Clear history for a user (optional)
  Future<int> clearHistory(int userId) {
     return (delete(history)..where((entry) => entry.userId.equals(userId))).go();
  }
}