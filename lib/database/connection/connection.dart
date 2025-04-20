// !!! IMPORTANT !!!
// DO NOT commit database credentials directly into your code.
// Use environment variables (flutter_dotenv) or a configuration file
// that is listed in your .gitignore.
// For development, you might hardcode them temporarily, but change before sharing/deploying.


import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:postgres/postgres.dart' as pg;

String _dbHost = dotenv.env['DATABASE_HOST']!;
int _dbPort = int.parse(dotenv.env['DATABASE_PORT']!);
String _dbName = dotenv.env['DATABASE_NAME']!;
String _dbUsername = dotenv.env['DATABASE_USER']!;
String _dbPassword = dotenv.env['DATABASE_PASSWORD']!;


DatabaseConnection connect() {
  final pgConnection = PgDatabase(
    endpoint: pg.Endpoint(
      host: _dbHost,
      port: _dbPort,
      database: _dbName,
      username: _dbUsername,
      password: _dbPassword,
  ),
  settings: const pg.ConnectionSettings(
    sslMode: pg.SslMode.require
  ));
  //return DatabaseConnection(PgDatabase(endpoint: pgConnection));
  return DatabaseConnection(pgConnection);
}