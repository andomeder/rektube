import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/models/user.dart';
import 'package:rektube/repositories/auth_repository.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/models/user.dart';
import 'package:rektube/providers/repository_providers.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AppUser?>>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return AuthController(authRepository, ref)..init();
    });

class AuthController extends StateNotifier<AsyncValue<AppUser?>> {
  final AuthRepository _authRepository;
  final Ref _ref;
  StreamSubscription? _authSubscription;

  AuthController(this._authRepository, this._ref)
    : super(const AsyncValue.loading());

  void init() {
    // Listen to the repository's auth state stream
    _authSubscription = _authRepository.authStateChanges.listen(
      (appUser) {
        state = AsyncValue.data(appUser);
        print(
          "AuthController received auth state update: ${appUser?.username ?? 'Logged out'}",
        );
      },
      onError: (error, stackTrace) {
        print("Error in auth state stream: $error");
        state = AsyncValue.error(error, stackTrace);
      },
    );

    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    try {
      await _authRepository.checkInitialAuthStatus();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  AppUser? get currentUser => state.valueOrNull;

  Future<void> manualLogout() async {
    try {
      await _authRepository.logout();
      Get.offAllNamed(AppRoutes.login);
    } catch (e, st) {
      print("Logout error: $e");
      state = AsyncValue.error(e, st);
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    print("AuthController disposed, auth subscription cancelled.");
    super.dispose();
  }
}
