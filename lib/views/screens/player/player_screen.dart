import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rektube/configs/constants.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/providers/player_providers.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/utils/helpers.dart';
import 'package:rektube/views/screens/core/library_screen.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isSeeking = false;
  double _sliderValue = 0.0;

  late final PlayerController playerController;

  @override
  void initState() {
    super.initState();
    playerController = Get.find<PlayerController>();
    // Initialize slider based on current position
    _sliderValue = playerController.position.value.inSeconds.toDouble();

    // Listen to position changes ONLY when not seeking
    playerController.position.stream.listen((position) {
      if (!_isSeeking && mounted) {
        setState(() {
          _sliderValue = position.inSeconds.toDouble();
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Now Playing"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          final track = playerController.currentTrack.value;
          final isPlaying = playerController.isPlaying.value;
          final duration = playerController.duration.value;

          if (track == null) {
            return const Center(
              heightFactor: 5.0,
              child: Text("No track selected."),
            );
          }

          final fullThumbnailUrl =
              track.thumbnailPath != null && track.thumbnailPath!.isNotEmpty
                  ? '$pipedInstanceUrl${track.thumbnailPath}' 
                  : null;
          final double maxSliderValue =
              duration > Duration.zero ? duration.inSeconds.toDouble() : 1.0;
          if (_sliderValue > maxSliderValue) {
            _sliderValue = maxSliderValue;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 10.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom * 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Top Spacer or Album Art Area
                  Column(
                    children: [
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child:
                              fullThumbnailUrl != null
                                  ? Image.network(
                                    fullThumbnailUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (c, e, s) => const Center(
                                          child: Icon(
                                            Icons.music_note,
                                            size: 80,
                                          ),
                                        ),
                                    loadingBuilder:
                                        (c, w, p) =>
                                            p == null
                                                ? w
                                                : const Center(
                                                  child: LoadingIndicator(),
                                                ),
                                  )
                                  : const Center(
                                    child: Icon(Icons.music_note, size: 80),
                                  ),
                        ),
                      ),
                      Text(
                        track.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        track.artist,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 15),
                      Consumer(
                        builder: (context, ref, child) {
                          final currentTrack =
                              playerController.currentTrack.value;
                          final userId =
                              ref.watch(authControllerProvider).valueOrNull?.id;
                          final isLikedAsync = ref.watch(
                            isTrackLikedProvider(
                              currentTrack?.id ?? '',
                            ), 
                          );

                          final bool canLike =
                              userId != null && currentTrack != null;

                          return IconButton(
                            iconSize: 30,
                            icon: isLikedAsync.when(
                              data:
                                  (isLiked) => Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isLiked
                                            ? theme.colorScheme.primary
                                            : Colors.grey,
                                  ),
                              loading:
                                  () => const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                              error: (e, s) {
                                print(
                                  "Error watching isTrackLikedProvider: $e",
                                );
                                return const Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                );
                              },
                            ),
                            onPressed:
                                canLike
                                    ? () async {
                                      final libraryRepo = ref.read(
                                        libraryRepositoryProvider,
                                      );
                                      final currentlyLiked =
                                          isLikedAsync.value ?? false;
                                      try {
                                        if (currentlyLiked) {
                                          await libraryRepo.unlikeSong(
                                            userId!,
                                            currentTrack!.id,
                                          ); 
                                        } else {
                                          await libraryRepo.likeSong(
                                            userId!,
                                            currentTrack!,
                                          );
                                        }
                                        ref.invalidate(
                                          isTrackLikedProvider(currentTrack.id),
                                        );
                                        ref.invalidate(
                                          likedSongsStreamProvider,
                                        );
                                      } catch (e) {
                                        showSnackbar(
                                          "Error",
                                          "Could not update like status.",
                                          isError: true,
                                        );
                                      }
                                    }
                                    : null,
                          );
                        },
                      ),
                    ],
                  ),

                  // Seek Bar and Time Labels
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 7.0,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 15.0,
                          ),
                          trackHeight: 3.0,
                        ),
                        child: Slider(
                          value: _sliderValue.clamp(0.0, maxSliderValue),
                          min: 0.0,
                          max: maxSliderValue,
                          activeColor: theme.colorScheme.primary,
                          inactiveColor: Colors.grey.withValues(alpha: 0.4),
                          onChangeStart: (value) {
                            setState(() {
                              _isSeeking = true; // Start seeking
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _sliderValue =
                                  value; 
                            });
                          },
                          onChangeEnd: (value) {
                            playerController.seek(
                              Duration(seconds: value.toInt()),
                            );
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () {
                                if (mounted) {
                                  setState(() {
                                    _isSeeking = false; 
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(
                                Duration(seconds: _sliderValue.toInt()),
                              ),
                              style: theme.textTheme.bodySmall,
                            ),
                            Text(
                              _formatDuration(duration),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      //const SizedBox(height: 10),
                    ],
                  ),

                  // Playback Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => IconButton(
                            iconSize: 26,
                            icon: const Icon(Icons.shuffle),
                            color:
                                playerController.isShuffled.value
                                    ? theme.colorScheme.primary
                                    : Colors.grey,
                            onPressed:
                                playerController
                                    .toggleShuffle, 
                          ),
                        ),
                        IconButton(
                          iconSize: 36,
                          icon: const Icon(Icons.skip_previous_rounded),
                          color:
                              playerController.currentQueue.isNotEmpty
                                  ? theme.colorScheme.onSurface
                                  : Colors.grey,
                          onPressed:
                              playerController
                                  .previous, 
                        ),
                        IconButton(
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_filled_rounded,
                          ),
                          color: theme.colorScheme.primary,
                          onPressed: playerController.playPause,
                        ),
                        IconButton(
                          iconSize: 36,
                          icon: const Icon(Icons.skip_next_rounded),
                          color:
                              playerController.currentQueue.isNotEmpty
                                  ? theme.colorScheme.onSurface
                                  : Colors.grey,
                          onPressed:
                              playerController.next, 
                        ),
                        Obx(() {
                          IconData repeatIcon;
                          Color repeatColor;
                          switch (playerController.repeatMode.value) {
                            case RepeatMode.off:
                              repeatIcon = Icons.repeat;
                              repeatColor = Colors.grey;
                              break;
                            case RepeatMode.one:
                              repeatIcon = Icons.repeat_one;
                              repeatColor = theme.colorScheme.primary;
                              break;
                            case RepeatMode.all:
                              repeatIcon = Icons.repeat;
                              repeatColor = theme.colorScheme.primary;
                              break;
                          }
                          return IconButton(
                            iconSize: 26,
                            icon: Icon(repeatIcon),
                            color: repeatColor,
                            onPressed:
                                playerController
                                    .cycleRepeatMode,
                          );
                        }),
                      ],
                    ),
                  ),
                  //SizedBox(
                  //height: MediaQuery.of(context).size.height * 0.05,
                  //), // Bottom padding
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
