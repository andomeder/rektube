import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/utils/routes.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the PlayerController instance registered with GetX
    final PlayerController playerController = Get.find<PlayerController>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Obx(() {
      final Track? currentTrack = playerController.currentTrack.value;
      final bool isPlaying = playerController.isPlaying.value;
      final Duration position = playerController.position.value;
      final Duration duration = playerController.duration.value;

      // If no track is loading/playing, display nothing (or an empty container)
      if (currentTrack == null) {
        return const SizedBox.shrink();
      }

      //Calculate progress (handle division by zero)
      final double progress =
          (duration.inMilliseconds > 0)
              ? (position.inMilliseconds / duration.inMilliseconds).clamp(
                0.0,
                1.0,
              )
              : 0.0;
      return GestureDetector(
        onTap: () {
          // TODO: Navigate to full player screen (Player Screen)
          print("MiniPlayer tapped - Navigate to full screen");
         Get.toNamed(AppRoutes.player);
        },
        child: Container(
          height: 65,
          color: colorScheme.surfaceContainerHighest,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Optional: Linear progress inidcator at the top
              if (duration > Duration.zero)
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 2.5,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child:
                            currentTrack.thumbnailUrl != null
                                ? Image.network(
                                  currentTrack.thumbnailUrl!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                )
                                : Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.grey[700],
                                  child: const Icon(Icons.music_note, size: 24),
                                ),
                      ),
                    ),
                    //Track Info (Title & Artist) - Takes available space
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTrack.title,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              currentTrack.artist,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant.withOpacity(
                                  0.7,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Play/Pause Button
                    IconButton(
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 32,
                        color: colorScheme.primary,
                      ),
                      onPressed: playerController.playPause,
                    ),
                    // Optional: Close/Stop Button?
                    IconButton(
                      icon: Icon(Icons.close, size: 24),
                      onPressed: playerController.stop,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
