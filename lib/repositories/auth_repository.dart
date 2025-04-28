import 'dart:async';

//import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rektube/configs/constants.dart';
import 'package:rektube/database/daos/user_dao.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/utils/exceptions.dart';
import 'package:rektube/utils/secure_storage.dart';
import 'package:rektube/models/user.dart' as model_user;
import 'package:bcrypt/bcrypt.dart';
import 'package:drift/drift.dart';

class AuthRepository {
  final UserDao _userDao;
  final SecureStorageService _secureStorage;

  // StreamController to broadcast authentication state changes.
  final _authStateController =
      StreamController<model_user.AppUser?>.broadcast();

  Stream<model_user.AppUser?> get authStateChanges =>
      _authStateController.stream;

  AuthRepository(this._userDao, this._secureStorage);

  void dispose() {
    _authStateController.close();
  }

  Future<model_user.AppUser> signUp({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) async {
    // Check if username or email already exists
    final existingByUsername = await _userDao.findUserByUsername(username);
    if (existingByUsername != null) {
      throw AuthException('Username already taken.');
    }
    final existingByEmail = await _userDao.findUserByEmail(email);
    if (existingByEmail != null) {
      throw AuthException('Email address already registered.');
    }

    // Hash the password
    final String hashedPassword = await _hashPassword(password);

    // Create the user companion
    final userCompanion = UsersCompanion.insert(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      passwordHash: hashedPassword,
      //createdAt: DateTime.now().toUtc(),
      //updatedAt: DateTime.now().toUtc(),
    );

    try {
      final userId = await _userDao.createUser(userCompanion);

      final dbUser = await _userDao.findUserById(userId);
      if (dbUser == null) {
        throw DatabaseException(
          "Failed to retrieve created user after insert.",
        );
      }

      await _handleLoginSuccess(dbUser);
      final appUser = model_user.AppUser.fromDbUser(dbUser);
      _authStateController.add(appUser);
      return appUser;
    } catch (e, st) {
      print("Sign up Error: $e");
      print("Stack trace: $st");
      if (e is DatabaseException || e is AuthException) {
        rethrow;
      }
      throw DatabaseException(
        "Failed to create user account. Please try again.",
      );
    }
  }

  Future<model_user.AppUser> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    User? dbUser =
        await _userDao.findUserByUsername(usernameOrEmail) ??
        await _userDao.findUserByEmail(usernameOrEmail);
    if (dbUser == null) {
      throw AuthException('Invalid username/email or password.');
    }

    final bool passwordMatches = await _verifyPassword(
      password,
      dbUser.passwordHash,
    );
    if (!passwordMatches) {
      throw AuthException('Invalid username/email or password.');
    }

    await _handleLoginSuccess(dbUser);
    final appUser = model_user.AppUser.fromDbUser(dbUser);
    _authStateController.add(appUser);
    return appUser;
  }

  Future<void> logout() async {
    await _secureStorage.deleteAll();
    _authStateController.add(null);
    print("User logged out and auth stream updated.");
  }

  Future<String> _hashPassword(String password) async {
    //return await Future(() => BCrypt.hashpw(password, BCrypt.gensalt()));
    //return await compute(BCrypt.hashpw, password, BCrypt.gensalt());
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  Future<bool> _verifyPassword(String password, String hash) async {
    try {
      // return await compute(BCrypt.checkpw, password, hash);
      return BCrypt.checkpw(password, hash);
    } catch (e) {
      print("Password verification error: $e");
      return false;
    }
  }

  Future<void> _handleLoginSuccess(User dbUser) async {
    await _secureStorage.saveUserId(dbUser.id.toString());
    final _getStorage = GetStorage();
    await _getStorage.write(storageUsernameKey, dbUser.username);

    print(
      "Login successful handled for user ID: ${dbUser.id}. User ID stored securely.",
    );
  }

  // Method to chack initial auth status (eg on app startup)
  Future<model_user.AppUser?> checkInitialAuthStatus() async {
    final userIdStr = await _secureStorage.getUserId();
    model_user.AppUser? appUser;
    User? dbUser;

    if (userIdStr != null) {
      final userId = int.tryParse(userIdStr);
      if (userId != null) {
        final dbUser = await _userDao.findUserById(userId);
        if (dbUser != null) {
          print("User $userId found from secure storage ID.");
          appUser = model_user.AppUser.fromDbUser(dbUser);
        }
      }
    }

    if (appUser == null) {
      await _secureStorage.deleteAll();
      print("No valid user session found in secure storage.");
    } else {
      print("Initial Auth - dbUser.createdAt (String): ${dbUser?.createdAt}");
      print("Initial Auth - dbUser.updatedAt (String): ${dbUser?.updatedAt}");
    }

    _authStateController.add(appUser);
    return appUser;
  }
}
