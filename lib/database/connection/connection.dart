// !!! IMPORTANT !!!
// DO NOT commit database credentials directly into your code.
// Use environment variables (flutter_dotenv) or a configuration file
// that is listed in your .gitignore.
// For development, you might hardcode them temporarily, but change before sharing/deploying.


import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:postgres/postgres.dart' as pg;

String _dbHost = dotenv.env['DATABASE_HOST'] ?? 'localhost';
int _dbPort = int.tryParse(dotenv.env['DATABASE_PORT'] ?? '5432') ?? 5432;
String _dbName = dotenv.env['DATABASE_NAME'] ?? 'rektube';
String _dbUsername = dotenv.env['DATABASE_USER'] ?? 'postgres';
String _dbPassword = dotenv.env['DATABASE_PASSWORD'] ?? '';


DatabaseConnection connect() {
  print("Attempting to connect to DB: Host=$_dbHost, Port=$_dbPort, DB=$_dbName, User=$_dbUsername");
  final pgConnection = PgDatabase(
    endpoint: pg.Endpoint(
      host: _dbHost,
      port: _dbPort,
      database: _dbName,
      username: _dbUsername,
      password: _dbPassword,
  ),
  settings: const pg.ConnectionSettings(
    sslMode: pg.SslMode.disable,
    timeZone: 'UTC', // Explicitly set time zone to UTC
  ));
  //return DatabaseConnection(PgDatabase(endpoint: pgConnection));
  print("PgDatabase instance created for connection.");
  return DatabaseConnection(pgConnection);
}