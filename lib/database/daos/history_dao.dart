import 'package:drift/drift.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/database/tables/history.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: [History])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  Stream<List<HistoryEntry>> watchRecentHistory(int userId, {int limit = 50}) {
    return (select(history)
          ..where((entry) => entry.userId.equals(userId))
          ..orderBy([(entry) => OrderingTerm(expression: entry.playedAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .watch();
  }

  Future<int> logPlayback(HistoryCompanion entry) {
     return into(history).insert(entry);
  }


  Future<int> clearHistory(int userId) {
     return (delete(history)..where((entry) => entry.userId.equals(userId))).go();
  }
}