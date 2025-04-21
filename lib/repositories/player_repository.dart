import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart' as media_kit;
import 'package:piped_client/piped_client.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/utils/exceptions.dart';
import 'package:rektube/utils/helpers.dart';

class PlayerRepository {
  final Ref _ref;
  final media_kit.Player _player;

    // State Streams exposed by the repository
    // Stream for the currently playing track (or null if none)
    final _currentTrackController = StreamController<Track?>.broadcast();
    Stream<Track?> get currentTrackStream => _currentTrackController.stream;
    Track? _currentTrack;

    //Expose player state streams directly
    Stream<bool> get isPlayingStream => _player.stream.playing;
    Stream<Duration> get positionStream => _player.stream.position;
    Stream<Duration> get durationStream => _player.stream.duration;
    Stream<bool> get isBufferingStream => _player.stream.buffering;
    Stream<double> get volumeStream => _player.stream.volume;
    Stream<double> get rateStream => _player.stream.rate;


    PlayerRepository(this._ref)
        : _player = media_kit.Player(configuration: const media_kit.PlayerConfiguration(
          logLevel: media_kit.MPVLogLevel.warn,
        )) {
          // Optional: Listen to player events internally if needed
          _player.stream.completed.listen((completed) {
            if (completed) {
              print("PlayerRepository: Playback completed.");
              _currentTrack = null;
              _currentTrackController.add(null);
              // TODO: IMplement logic for playing next track in queue
            }
          });

          _player.stream.error.listen((error) {
            print("PlayerRepository: Plyer Error: $error");

            // Handle player errors
            _currentTrack = null;
            _currentTrackController.add(null);
          });
        }
    // Get the current player state synchronously (use streams primarily)
    media_kit.PlayerState get playerState => _player.state;
    Track? get currentTrack => _currentTrack;

    /// Plays a given track. Fetches stream URL via PipedRepository.
    Future<void> playTrack(Track track) async {
      print("PlayerRepository: Attempting to play track '${track.title}' (ID: ${track.id})");
      _currentTrack = track;
      _currentTrackController.add(track);

      try {
        final pipedRepo = _ref.read(pipedRepositoryProvider);
        final streamInfoJson = await pipedRepo.getStreamInfoJson(track.id);

        // Find a suitable audio stream (e.g., highest quality m4a)
        //final audioStream = streamInfo.audioStreams ?.where((s) => s.mimeType == 'audio/mp4' || s.mimeType == 'audio/webm').cast<PipedAudioStream>().lastOrNull;
        //if (audioStream == null || audioStream.url == null) {
          //throw Exception("No suitable audio stream found for track '${track.title}'");
        //}

        // *** Parse the JSON response manually (or create a model class) ***
          final audioStreamsData = streamInfoJson['audioStreams'] as List<dynamic>?;

          if (audioStreamsData == null || audioStreamsData.isEmpty) {
             throw PipedException("No audio streams found in JSON response for ${track.title}");
          }

          // Find the best stream based on your criteria (e.g., m4a, highest bitrate)
          Map<String, dynamic>? bestStream;
          int highestBitrate = -1;

          for (var streamData in audioStreamsData) {
             if (streamData is Map<String, dynamic>) {
                 final mimeType = streamData['mimeType'] as String?;
                 final bitrate = streamData['bitrate'] as int?; // Bitrate might be missing or 0

                 // Prioritize m4a/mp4, then webm
                 if ((mimeType == 'audio/mp4' || mimeType == 'audio/m4a')) {
                    // Example: Choose highest bitrate m4a
                    if (bitrate != null && bitrate > highestBitrate) {
                       highestBitrate = bitrate;
                       bestStream = streamData;
                    } else if (bestStream == null || (bestStream['mimeType'] != 'audio/mp4' && bestStream['mimeType'] != 'audio/m4a')) {
                         // If no higher bitrate found, take the first m4a
                         bestStream ??= streamData;
                    }
                 } else if (mimeType == 'audio/webm' && bestStream == null) {
                    // Fallback to webm if no m4a found yet
                    bestStream ??= streamData;
                 }
             }
          }

        //print("PlayerRepository: Found audio stream URL: ${audioStream.url}");

        //// Create Media object and open in player
        //final media = media_kit.Media(audioStream.url);
        //await _player.open(media, play: true);
        //print("PlayerRepository: Opened media in player for ${track.title}");

        final originalStreamUrl = bestStream?['url'] as String?; // Get original URL

        if (originalStreamUrl == null) {
          throw PipedException("Could not extract audio stream URL for ${track.title}");
        }

        print("PlayerRepository: Original stream URL from API: $originalStreamUrl");

        // *** Use the helper function to get the final URL for the player ***
        final playableStreamUrl = rewritePipedUrlForLocalDev(originalStreamUrl);

        if (playableStreamUrl.isEmpty) { // Check if rewrite failed or URL was null
          throw PlayerException("Invalid stream URL after rewrite.");
        }

        print("PlayerRepository: Final URL passed to player: $playableStreamUrl");
        final media = media_kit.Media(playableStreamUrl); // Use rewritten URL
        await _player.open(media, play: true);
        print("PlayerRepository: Opened media in player for ${track.title}");
        // *** Log Playback to History ***
        try {
          final authState = _ref.read(authControllerProvider); // Get current auth state
          final userId = authState.valueOrNull?.id;
          if (userId != null && _currentTrack != null) { // Ensure user logged in and track set
            final libraryRepo = _ref.read(libraryRepositoryProvider);
            // Run logging in background, don't wait for it
            libraryRepo.logPlayback(userId, _currentTrack!);
            print("PlayerRepository: Logged playback for track ID ${_currentTrack!.id}");
          }
        } catch (e) {
          // Log error but don't let it stop playback flow
          print("PlayerRepository: Failed to log playback - $e");
        }

      } catch (e, stackTrace) {
        print("PlayerRepository: Error playing track ${track.title}: $e\n$stackTrace");
        _currentTrack = null; // Clear track on error
        _currentTrackController.add(null);

        // Rethrow or handle specific exceptions
        if (e is PipedException || e is NetworkException || e is PlayerException) rethrow;
        throw PlayerException("Failed to play track: ${e.toString()}");
      }
    }

    // --- Basic Playback Controls ---
    Future<void> play() async => await _player.play();
    Future<void> pause() async => await _player.pause();
    Future<void> playOrPause() async => await _player.playOrPause();

    Future<void> seek(Duration position) async {
       // Check if seek is possible (e.g., duration is known)
       if (_player.state.duration > Duration.zero) {
         await _player.seek(position);
       }
    }

    Future<void> setVolume(double volume) async => await _player.setVolume(volume.clamp(0.0, 100.0)); // media_kit uses 0-100
    Future<void> setRate(double rate) async => await _player.setRate(rate.clamp(0.25, 4.0)); // Example rate limits

    Future<void> stop() async {
      print("PlayerRepository: Stopping playback");
      await _player.stop();
      _currentTrack = null;
      _currentTrackController.add(null);
    }

    /// Dispose the player when the repository is no longer needed.
    Future<void> dispose() async {
      print("PlayerRepository: Disposing player");
      _currentTrackController.close();
      await _player.dispose();
    }
}

// Custom exception for player specific errors
class PlayerException implements AppException {
  PlayerException(String message) : super();
  
  @override
  // TODO: implement code
  String? get code => throw UnimplementedError();
  
  @override
  // TODO: implement message
  String get message => throw UnimplementedError();
}