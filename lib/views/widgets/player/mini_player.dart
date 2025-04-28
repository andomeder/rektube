import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/constants.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/utils/routes.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlayerController playerController = Get.find<PlayerController>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Obx(() {
      final Track? currentTrack = playerController.currentTrack.value;
      final bool isPlaying = playerController.isPlaying.value;
      final Duration position = playerController.position.value;
      final Duration duration = playerController.duration.value;
      

      if (currentTrack == null) {
        return const SizedBox.shrink();
      }

      final fullThumbnailUrl = currentTrack.thumbnailPath != null ? '$pipedInstanceUrl${currentTrack.thumbnailPath}' : null;

      //Calculate progress
      final double progress =
          (duration.inMilliseconds > 0)
              ? (position.inMilliseconds / duration.inMilliseconds).clamp(
                0.0,
                1.0,
              )
              : 0.0;
      return GestureDetector(
        onTap: () {
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
              if (duration > Duration.zero)
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 2.5,
                  backgroundColor: Colors.grey.withValues(alpha: 0.3),
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
                            fullThumbnailUrl != null
                                ? Image.network(
                                  fullThumbnailUrl,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c,e,s) => Container(width: 40, height: 40, color: Colors.grey[700], child: const Icon(Icons.music_note, size: 24)),
                                )
                                : Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.grey[700],
                                  child: const Icon(Icons.music_note, size: 24),
                                ),
                      ),
                    ),
                    //Track Info (Title & Artist)
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
                                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
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
