// Provider to easily access the PlayerController instance via GetX
// final playerControllerProvider = Provider((ref) => Get.find<PlayerController>());

import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/repositories/player_repository.dart';

enum RepeatMode { off, one, all }

class PlayerController extends GetxController {
  final PlayerRepository _playerRepository;

  // Reactive UI State Variables
  final Rx<Track?> currentTrack = Rx<Track?>(null);
  final RxBool isPlaying = false.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final RxBool isBuffering = false.obs;
  final RxDouble volume = 100.0.obs;

  // Queue Management State
  final RxList<Track> currentQueue = <Track>[].obs;
  final RxList<Track> originalQueue = <Track>[].obs;
  final RxInt currentIndex = (-1).obs;
  final RxBool isShuffled = false.obs;
  final Rx<RepeatMode> repeatMode = RepeatMode.off.obs;

  final Random _random = Random();

  StreamSubscription? _trackSubscription;
  StreamSubscription? _playingSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _bufferingSubscription;
  StreamSubscription? _volumeSubscription;

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
      if (duration.value > Duration.zero) {
        position.value = pos;
      }
    });
    _durationSubscription = _playerRepository.durationStream.listen((dur) {
      duration.value = dur;
    });
    _bufferingSubscription = _playerRepository.isBufferingStream.listen((
      buffering,
    ) {
      isBuffering.value = buffering;
    });
    _volumeSubscription = _playerRepository.volumeStream.listen((vol) {
      volume.value = vol;
    });
    print("PlayerController subscribed to player streams.");
  }

  // UI Actions
  void play(Track track, WidgetRef ref) {
    print("PlayerController play called for single track: ${track.title}");
    loadQueue([track], startIndex: 0);
  }

  void playPause() {
    _playerRepository.playOrPause();
  }

  void seek(Duration position) {
    this.position.value = position;
    _playerRepository.seek(position);
  }

  void setVolume(double volume) {
    _playerRepository.setVolume(volume);
  }

  void stop() {
    _playerRepository.stop();
  }

  void loadQueue(List<Track> queue, {int startIndex = 0}) {
    print(
      "Loading new queue with ${queue.length} tracks. StartIndex: $startIndex",
    );
    originalQueue.assignAll(queue);

    if (isShuffled.value) {
      _shuffleQueue(startIndex: startIndex);
    } else {
      currentQueue.assignAll(queue);
      currentIndex.value =
          (startIndex >= 0 && startIndex < queue.length) ? startIndex : -1;
    }

    if (currentIndex.value >= 0) {
      playTrackAtIndex(currentIndex.value);
    } else {
      stop();
    }
  }

  void _shuffleQueue({int? startIndex}) {
    if (originalQueue.isEmpty) return;

    Track? trackToPreserve;
    int originalIndexToPreserve = startIndex ?? currentIndex.value;

    if (originalIndexToPreserve >= 0 &&
        originalIndexToPreserve < originalQueue.length) {
      trackToPreserve = originalQueue[originalIndexToPreserve];
    }

    final shuffledList = List<Track>.from(originalQueue)..shuffle(_random);

    
    if (trackToPreserve != null) {
      currentIndex.value = shuffledList.indexWhere(
        (t) => t.id == trackToPreserve!.id,
      );
      if (currentIndex.value == -1) {
        // Should not happen if track was in original
        currentIndex.value = 0;
      }
    } else {
      
      currentIndex.value = 0;
    }
    currentQueue.assignAll(shuffledList);
    print("Queue shuffled. Current index: ${currentIndex.value}");
  }

  void playTrackAtIndex(int index) {
    if (index >= 0 && index < currentQueue.length) {
      currentIndex.value = index;
      final trackToPlay = currentQueue[index];
      print("Playing track at index $index: ${trackToPlay.title}");
      // Call the actual playback method in the repository
      _playerRepository.playTrack(trackToPlay);
    } else {
      print("Invalid index $index for queue length ${currentQueue.length}");
      stop();
    }
  }

  void next() {
    if (currentQueue.isEmpty) return;
    int nextIndex;

    if (repeatMode.value == RepeatMode.one) {
      seek(Duration.zero);
      _playerRepository.play();
      return;
    }

    if (isShuffled.value && currentQueue.length > 1) {
      int randomIndex;
      do {
        randomIndex = _random.nextInt(currentQueue.length);
      } while (randomIndex == currentIndex.value);
      nextIndex = randomIndex;
    } else {
      nextIndex = currentIndex.value + 1;
    }

    if (nextIndex >= currentQueue.length) {
      if (repeatMode.value == RepeatMode.all) {
        nextIndex = 0;
      } else {
        print("End of queue reached.");
        stop(); 
        return;
      }
    }
    playTrackAtIndex(nextIndex);
  }

  void previous() {
    if (currentQueue.isEmpty) return;

    if (position.value > const Duration(seconds: 3)) {
      seek(Duration.zero);
      return;
    }

    int prevIndex;
    prevIndex = currentIndex.value - 1;

    if (prevIndex < 0) {
      if (repeatMode.value == RepeatMode.all) {
        prevIndex = currentQueue.length - 1; // Wrap around
      } else {
        seek(Duration.zero); // Go to start of current track
        return;
      }
    }
    playTrackAtIndex(prevIndex);
  }

  void toggleShuffle() {
    isShuffled.value = !isShuffled.value;
    print("Shuffle toggled: ${isShuffled.value}");
    // Re-shuffle or revert to original order when toggled
    if (isShuffled.value) {
      _shuffleQueue();
      if (currentIndex.value >= 0 &&
          currentIndex.value < currentQueue.length) {}
    } else {
      Track? currentPlayingTrack =
          (currentIndex.value >= 0 && currentIndex.value < currentQueue.length)
              ? currentQueue[currentIndex.value]
              : null;
      currentQueue.assignAll(originalQueue);
      if (currentPlayingTrack != null) {
        currentIndex.value = originalQueue.indexWhere(
          (t) => t.id == currentPlayingTrack.id,
        );
        if (currentIndex.value == -1) currentIndex.value = 0;
      } else {
        currentIndex.value = 0;
      }
    }
  }

  void cycleRepeatMode() {
    int nextIndex = (repeatMode.value.index + 1) % RepeatMode.values.length;
    repeatMode.value = RepeatMode.values[nextIndex];
    print("Repeat mode cycled: ${repeatMode.value}");
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
