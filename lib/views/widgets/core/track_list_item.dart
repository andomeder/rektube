import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/configs/constants.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/models/track.dart';
import 'package:get/get.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/utils/exceptions.dart';
import 'package:rektube/utils/helpers.dart';
import 'package:rektube/views/screens/core/library_screen.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';

class TrackListItem extends ConsumerWidget {
  final Track track;
  final VoidCallback? onTap;

  const TrackListItem({super.key, required this.track, this.onTap});

  //Helper to formart duration
  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$minutes:$seconds";
    }

    return "$minutes:$seconds";
  }

  void _showAddToPlaylistDialog(
    BuildContext context,
    WidgetRef ref,
    Track trackToAdd,
  ) {
    final userId = ref.read(authControllerProvider).valueOrNull?.id;

    if (userId == null) return;

    // Watch user's playlists
    final playlistsAsync = ref.watch(playlistsStreamProvider);

    Get.dialog(
      AlertDialog(
        title: const Text("Add to Playlist"),
        content: SizedBox(
          width: double.maxFinite,
          child: playlistsAsync.when(
            data: (playlists) {
              if (playlists.isEmpty) {
                return const Text(
                  "No playlists found. Create one first in the library",
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlists[index];
                  return ListTile(
                    title: Text(playlist.name),
                    onTap: () async {
                      Get.back();
                      print(
                        "Attempting to add '${trackToAdd.title}' to playlist '${playlist.name}' (ID: ${playlist.id})",
                      );
                      try {
                        final libraryRepo = ref.read(libraryRepositoryProvider);
                        await libraryRepo.addTrackToPlaylist(
                          playlist.id,
                          trackToAdd,
                        );
                        print("Successfully added track.");
                        showSnackbar(
                          "Success",
                          "Added '${trackToAdd.title}' to '${playlist.name}'",
                        );
                      } on DatabaseException catch (e) {
                        // Catch specific DB errors
                        print("Database error adding track: $e");
                        showSnackbar(
                          "Error",
                          "Database error: ${e.message}",
                          isError: true,
                        );
                      } catch (e, st) {
                        // Catch any other errors
                        print("Generic error adding track: $e\n$st");
                        showSnackbar(
                          "Error",
                          "Failed to add track: $e",
                          isError: true,
                        );
                      }
                    },
                  );
                },
              );
            },
            error: (err, st) => Text("Error loading playlists: $err"),
            loading: () => const Center(child: LoadingIndicator()),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final fullThumbnailUrl =
        track.thumbnailPath != null
            ? '$pipedInstanceUrl${track.thumbnailPath}'
            : null;
    print("TrackListItem build: fullThumbnailUrl = $fullThumbnailUrl");

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 16.0,
      ),
      leading: SizedBox(
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child:
              fullThumbnailUrl != null
                  ? Image.network(
                    fullThumbnailUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(
                            child: SizedBox(
                              width: 20,
                              height: 200,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.music_note_outlined,
                          color: Colors.grey,
                        ),
                      );
                    },
                  )
                  : Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.music_note_outlined,
                      color: Colors.grey,
                    ),
                  ),
        ),
      ),
      title: Text(
        track.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        track.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium?.copyWith(color: colorHint),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatDuration(track.duration),
            style: textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: "Track Options",
            onSelected: (String result) {
              switch (result) {
                case 'add_playlist':
                  _showAddToPlaylistDialog(context, ref, track);
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'add_playlist',
                    child: ListTile(
                      leading: Icon(Icons.playlist_add),
                      title: Text("Add to Playlist"),
                    ),
                  ),
                ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
