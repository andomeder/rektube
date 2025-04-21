import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rektube/controllers/player/player_controller.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find<PlayerController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Now Playing")),
      body: Obx(() {
        final track = playerController.currentTrack.value;
        final isPlaying = playerController.isPlaying.value;
        final position = playerController.position.value;
        final duration = playerController.duration.value;

        if (track == null) {
          return const Center(child: Text("No track Playing"));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: Add Album Art / Thumbnail (large)
              Container(
                height: 250,
                width: 250,
                color: Colors.grey[800],
                margin: const EdgeInsets.only(bottom: 24.0),
                child:
                    track.thumbnailUrl != null
                        ? Image.network(track.thumbnailUrl!, fit: BoxFit.cover)
                        : const Icon(Icons.music_note, size: 100),
              ),

              // Track Title
              Text(
                track.title,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),

              // TODO: Add Seek Bar
              Text(
                "Seek Bar Placeholder (${position.toString().split('.')[0]} / ${duration.toString().split('.')[0]})",
              ),
              const SizedBox(height: 16),

              // TODO: Add Playback Controls (Play/Pause, Next, Previous, etc.)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 64,
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                    ),
                    color: theme.colorScheme.primary,
                    onPressed: playerController.playPause,
                  ),
                ],
              ),
              // TODO: Add Volume Control, Shuffle, Repeat etc.
            ],
          ),
        );
      }),
    );
  }
}
