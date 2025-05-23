import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/models/track.dart' as model_track;
import 'package:rektube/utils/routes.dart';
import 'package:rektube/views/screens/core/library_screen.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';

enum ProfileAction { settings, logout }

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(
      historyStreamProvider,
    ); // Watch history stream
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rektube"),
        automaticallyImplyLeading: false,
        actions: [
          // --- Profile/Settings Popup Menu Button ---
          PopupMenuButton<ProfileAction>(
            icon: const Icon(Icons.account_circle_rounded),
            tooltip: "Account Options",
            onSelected: (ProfileAction action) async {
              switch (action) {
                case ProfileAction.settings:
                  Get.toNamed(AppRoutes.settings);
                  print("Settings selected");
                  Get.snackbar("Info", "Settings menu not implemented yet.");
                  break;
                case ProfileAction.logout:
                  print("Logout selected");
                  await ref
                      .read(authControllerProvider.notifier)
                      .manualLogout();
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<ProfileAction>>[
                  const PopupMenuItem<ProfileAction>(
                    value: ProfileAction.settings,
                    child: ListTile(
                      leading: Icon(Icons.settings_rounded),
                      title: Text("Settings"),
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<ProfileAction>(
                    value: ProfileAction.logout,
                    child: ListTile(
                      leading: Icon(Icons.logout_rounded),
                      title: Text("Logout"),
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: [
          // --- Welcome Banner or Featured Content (Placeholder) ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Text(
              "Welcome Back!",
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // --- Recently Played Section ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Recently Played", style: textTheme.titleLarge),
          ),
          const SizedBox(height: 8),
          historyAsync.when(
            data: (history) {
              if (history.isEmpty) {
                return const ListTile(
                  dense: true,
                  title: Text("No recently played tracks."),
                );
              }
              return SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final entry = history[index];
                    final track = model_track.Track(
                      id: entry.trackId,
                      title: entry.trackTitle,
                      artist: entry.trackArtist,
                      thumbnailPath: entry.trackThumbnailPath,
                      duration:
                          entry.trackDurationSeconds != null
                              ? Duration(seconds: entry.trackDurationSeconds!)
                              : null,
                    );
                    return _buildHorizontalTrackCard(context, ref, track);
                  },
                ),
              );
            },
            loading:
                () => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: LoadingIndicator(),
                  ),
                ),
            error:
                (err, st) =>
                    ListTile(title: Text("Error loading history: $err")),
          ),
          const SizedBox(height: 24), 
          // --- Liked Songs Snippet ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Liked Songs", style: textTheme.titleLarge,),
                TextButton(onPressed: () {
                  //TODO: Navgate to full Liked Songs screen
                  Get.snackbar("Info", "Liked Songs screen not implemented");
                }, child: const Text("See all"),)
              ],
            ),
          ),
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, _) {
              final likedSongsAsync = ref.watch(likedSongsStreamProvider);
              return likedSongsAsync.when(
                data: (liked) {
                  if (liked.isEmpty) {
                    return const ListTile(dense: true, title: Text("No liked songs yet."),);
                  }
                  // Horizontal list
                  return SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      itemCount: liked.length > 10 ? 10 : liked.length,
                      itemBuilder: (context, index) {
                        final likedSong = liked[index];
                        final track = model_track.Track(id: likedSong.trackId, title: likedSong.trackTitle, artist: likedSong.trackArtist, thumbnailPath: likedSong.trackThumbnailPath, duration: likedSong.trackDurationSeconds != null ? Duration(seconds: likedSong.trackDurationSeconds!) : null);
                        return _buildHorizontalTrackCard(context, ref, track);
                      },
                      ),
                  );
                }, 
                error: (err, st) => ListTile(title: Text("Error loading liked songs: $err")),
                loading: () => const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 40.0), child: LoadingIndicator())),);
            }
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHorizontalTrackCard(
    BuildContext context,
    WidgetRef ref,
    model_track.Track track,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final playerController = Get.find<PlayerController>();

    return GestureDetector(
      onTap: () {
        print("Playing from Dashboard history: ${track.title}");
        playerController.play(track, ref);
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 1.0,
                child:
                    track.thumbnailPath != null
                        ? Image.network(
                          track.thumbnailPath!,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (c, e, s) => Container(
                                color: Colors.grey[800],
                                child: const Icon(Icons.music_note),
                              ),
                        )
                        : Container(
                          color: Colors.grey[800],
                          child: const Icon(Icons.music_note),
                        ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              track.title,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              track.artist,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
