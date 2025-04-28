import 'package:equatable/equatable.dart';
import 'package:rektube/database/database.dart';

class AppUser extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;

  const AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
  });

  factory AppUser.fromDbUser(User dbUser) {
    return AppUser(
      id: dbUser.id,
      firstName: dbUser.firstName,
      lastName: dbUser.lastName,
      username: dbUser.username,
      email: dbUser.email,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, username, email];
}