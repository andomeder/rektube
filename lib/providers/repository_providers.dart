// Provider for SecureStorageService
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/providers/database_providers.dart';
import 'package:rektube/repositories/auth_repository.dart';
import 'package:rektube/repositories/library_repository.dart';
import 'package:rektube/repositories/piped_repository.dart';
import 'package:rektube/repositories/player_repository.dart';
import 'package:rektube/utils/secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});


// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final userDao = ref.watch(userDaoProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthRepository(userDao, secureStorage);
});

// Provider for PipedRepository
final pipedRepositoryProvider = Provider<PipedRepository>((ref) {
  return PipedRepository();
});

// Provider for PlayerRepository
final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  final repository = PlayerRepository(ref);
  ref.onDispose(() => repository.dispose());
  return repository;
});

// Provider for LibraryRepository
final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {

  return LibraryRepository(ref);
});
