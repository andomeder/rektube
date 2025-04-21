// Provider to easily access the PlayerController instance via GetX
// final playerControllerProvider = Provider((ref) => Get.find<PlayerController>());


import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/repositories/player_repository.dart';

class PlayerController extends GetxController {
  final PlayerRepository _playerRepository;

  // --- Reactive UI State Variables ---
  final Rx<Track?> currentTrack = Rx<Track?>(null);
  final RxBool isPlaying = false.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final RxBool isBuffering = false.obs;
  final RxDouble volume = 100.0.obs; 

  // Stream Subscriptions - managed by the controller lifecycle
  StreamSubscription? _trackSubscription;
  StreamSubscription? _playingSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _bufferingSubscription;
  StreamSubscription? _volumeSubscription;

  // Constructor requires the repository
  PlayerController(this._playerRepository) {
    print("PlayerController: Initialized.");
    _subscribeToPlayerStreams();
    // Set initial state from repository
    currentTrack.value = _playerRepository.currentTrack;
    isPlaying.value = _playerRepository.playerState.playing;
    position.value = _playerRepository.playerState.position;
    duration.value = _playerRepository.playerState.duration;
    isBuffering.value = _playerRepository.playerState.buffering;
    volume.value = _playerRepository.playerState.volume;
  }

  void _subscribeToPlayerStreams() {
    _trackSubscription = _playerRepository.currentTrackStream.listen((track) {
      currentTrack.value = track;
    });
    _playingSubscription = _playerRepository.isPlayingStream.listen((playing) {
      isPlaying.value = playing;
    });
    _positionSubscription = _playerRepository.positionStream.listen((pos) {
      // Avoid updating excessively if duration is zero or position hasn't changed much
        if (duration.value > Duration.zero) {
           position.value = pos;
        }
    });
    _durationSubscription = _playerRepository.durationStream.listen((dur) {
      duration.value = dur;
    });
    _bufferingSubscription = _playerRepository.isBufferingStream.listen((buffering) {
      isBuffering.value = buffering;
    });
    _volumeSubscription = _playerRepository.volumeStream.listen((vol) {
      volume.value = vol;
    });
    print("PlayerController subscribed to player streams.");
  }

  // UI Actions
  void play(Track track, WidgetRef ref) {
    // **Simplification:** Assume playTrack in repo can get what it needs.
      _playerRepository.playTrack(track);
  }

  void playPause() {
     _playerRepository.playOrPause();
  }

  void seek(Duration position) {
    // Only update reactive state *after* seek is initiated
    this.position.value = position; // Optimistic update
    _playerRepository.seek(position);
  }

  void setVolume(double volume) {
    _playerRepository.setVolume(volume);
  }
  void stop() {
    _playerRepository.stop();
    // State clears via stream listeners
  }


  @override
  void onClose() {
    print("PlayerController: Closing controller.");
    // Unsubscribe from streams
    _trackSubscription?.cancel();
    _playingSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _bufferingSubscription?.cancel();
    _volumeSubscription?.cancel();

    super.onClose();
  }
}