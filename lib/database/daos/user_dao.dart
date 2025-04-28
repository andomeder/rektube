import 'package:drift/drift.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/database/tables/users.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  // Constructor that receives the database instance
  UserDao(super.db);

  // Custom methods
  Future<User?> findUserByUsername(String username) {
    return (select(users)..where((u) => u.username.equals(username)))
        .getSingleOrNull();
  }
  // Find a user by email
  Future<User?> findUserByEmail(String email) {
    return (select(users)..where((u) => u.email.equals(email)))
        .getSingleOrNull();
  }

  // Find a user by ID
   Future<User?> findUserById(int id) {
    return (select(users)..where((u) => u.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> createUser(UsersCompanion user) {
    return into(users).insert(user); 
  }
}