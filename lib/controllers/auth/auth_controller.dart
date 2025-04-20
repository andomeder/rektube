import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/models/user.dart';
import 'package:rektube/repositories/auth_repository.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/models/user.dart';
import 'package:rektube/providers/repository_providers.dart';


final authControllerProvider = StateNotifierProvider<
  AuthController,
  AsyncValue<AppUser?>
>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  // Pass ref for potential future use, though direct dependencies are preferred
  return AuthController(authRepository, ref)
    ..init(); // Call init after creation
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
        // Update the state notifier's state when the stream emits a new value
        state = AsyncValue.data(appUser);
        print(
          "AuthController received auth state update: ${appUser?.username ?? 'Logged out'}",
        );
      },
      onError: (error, stackTrace) {
        // Handle errors in the stream
        print("Error in auth state stream: $error");
        state = AsyncValue.error(error, stackTrace);
      }
    );

    //Perform initial auth check after setting up the listener
    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    // Set state to loading before checking auth status
    // state = const AsyncValue.loading(); // Already set in constructor
    try {
      // Let the repository check and emit the initial state via the stream
          await _authRepository.checkInitialAuthStatus();
    } catch (e, st) {
      // If checkInitialAuthStatus itself throws an error before emitting
          state = AsyncValue.error(e, st);
    }
  }

  // Expose current user synchronously if data is available
    AppUser? get currentUser => state.valueOrNull;

    Future<void> manualLogout() async {
       // Set state to loading while logging out (optional, depends on UX preference)
       // state = const AsyncValue.loading();
       try {
          // Tell the repository to log out. The repository will update its stream.
          await _authRepository.logout();
          // The listener will automatically update the state to AsyncValue.data(null).
          Get.offAllNamed(AppRoutes.login); // Navigate after logout completes
       } catch (e, st) {
          print("Logout error: $e");
          // Update state to reflect the error during logout
          state = AsyncValue.error(e, st);
          // Optionally show a snackbar or message to the user here
       }
    }
    // Override dispose to cancel the stream subscription
    @override
    void dispose() {
      _authSubscription?.cancel(); // Cancel the subscription
      print("AuthController disposed, auth subscription cancelled.");
      super.dispose();
    }
}
