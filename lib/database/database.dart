import 'package:drift/drift.dart';
import 'package:rektube/database/tables/users.dart';
import 'package:rektube/database/connection/connection.dart' as conn;
import 'package:rektube/database/daos/user_dao.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Users], daos: [UserDao])

class AppDatabase extends _$AppDatabase {
  // Constructor that takes the connection query excutor
  AppDatabase(QueryExecutor e) : super(e);

  // Define a factory constructor or singleton for easier access (optional)
  static final AppDatabase instance = AppDatabase(conn.connect().executor);

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
       // Can run custom statements or checks before the DB is fully ready
       if (details.wasCreated) {
          print('Database was created!');
       } else if (details.hadUpgrade) {
          print('Database was upgraded from ${details.versionBefore} to ${details.versionNow}');
       }
       print('Database is open. Schema version: ${details.versionNow}');
     }
  );
}