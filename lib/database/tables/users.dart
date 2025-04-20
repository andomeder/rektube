import 'package:drift/drift.dart';

@DataClassName('User', extending: Table)

class Users extends Table {

  @override
  String get tableName => 'users';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  TextColumn get username => text().unique()();
  TextColumn get email => text().unique()();
  TextColumn get password => text().named('password_hash')();

  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').withDefault(currentDateAndTime)();
}