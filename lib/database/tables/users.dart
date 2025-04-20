import 'package:drift/drift.dart';
import 'package:rektube/database/type_converters.dart';

@DataClassName('User', extending: Table)

class Users extends Table {

  @override
  String get tableName => 'users';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  TextColumn get username => text().unique()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text().named('password_hash')();

  DateTimeColumn get createdAt => dateTime().named('created_at').map(const TimestampNoTzConverter() as TypeConverter<dynamic, DateTime>)();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').map(const TimestampNoTzConverter() as TypeConverter<dynamic, DateTime>)();
  //TextColumn get createdAt => text().named('created_at')();
  //TextColumn get updatedAt => text().named('updated_at')();
}