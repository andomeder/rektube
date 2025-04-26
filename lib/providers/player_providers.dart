import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/providers/repository_providers.dart';

final isCurrentTrackLikedProvider = FutureProvider.autoDispose<bool>((ref) async {
  final userId = ref.watch(authControllerProvider).valueOrNull?.id;
  // Wwatch the player conroller's curent track ID
  final trackId = ref.watch(playerControllerProvider.select((pc) => pc.currentTrack.value?.id));
  final libraryRepo = ref.watch(libraryRepositoryProvider);

  if (userId == null || trackId == null) {
    return false;
  }

  return libraryRepo.isLiked(userId, trackId);
});


final playerControllerProvider = Provider<PlayerController>((ref) {
  throw UnimplementedError("PlayerController instance needs to be provided or found");
});