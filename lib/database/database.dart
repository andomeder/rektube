import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:rektube/database/daos/history_dao.dart';
import 'package:rektube/database/daos/liked_song_dao.dart';
import 'package:rektube/database/daos/playlist_dao.dart';
import 'package:rektube/database/daos/playlist_item_dao.dart';
import 'package:rektube/database/tables/history.dart';
import 'package:rektube/database/tables/liked_songs.dart';
import 'package:rektube/database/tables/playlist_items.dart';
import 'package:rektube/database/tables/playlists.dart';
import 'package:rektube/database/tables/users.dart';
import 'package:rektube/database/connection/connection.dart' as conn;
import 'package:rektube/database/daos/user_dao.dart';
import 'package:rektube/database/type_converters.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Playlists, // Add new tables
    PlaylistItems,
    LikedSongs,
    History,
  ],
  daos: [
    UserDao,
    PlaylistDao, // Add new DAOs
    PlaylistItemDao,
    LikedSongDao,
    HistoryDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  // Define a factory constructor or singleton for easier access (optional)
  static final AppDatabase instance = AppDatabase(conn.connect().executor);

  // Register type converters globally
  @override
    Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  // Schema version
  @override
  int get schemaVersion => 1;

  // Optional: Migration strategy
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll(); // Creates all tables based on definitions
      print("Drift database tables created!");
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Implement logic for upgrading schema versions here later
      print("Upgrading database schema from $from to $to");
      if (from < 2) {
        // Example: await m.addColumn(users, users.newColumn);
      }
    },
    beforeOpen: (details) async {
       if (details.wasCreated) {
          print('Database was created!');
       } else if (details.hadUpgrade) {
          print('Database was upgraded from ${details.versionBefore} to ${details.versionNow}');
       }
       print('Database is open. Schema version: ${details.versionNow}');
     }
  );
}