import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/models/track.dart' as model_track;
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/utils/helpers.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';
import 'package:rektube/views/widgets/core/track_list_item.dart';


final playlistsStreamProvider = StreamProvider.autoDispose<List<Playlist>>((ref) {
  final userId = ref.watch(authControllerProvider).valueOrNull?.id;
  if (userId == null) return Stream.value([]);
  final libraryRepo = ref.watch(libraryRepositoryProvider);
  return libraryRepo.watchUserPlaylists(userId);
});

final likedSongsStreamProvider = StreamProvider.autoDispose<List<LikedSong>>((ref) {
  final userId = ref.watch(authControllerProvider).valueOrNull?.id;
  if (userId == null) return Stream.value([]);
  final libraryRepo = ref.watch(libraryRepositoryProvider);
  return libraryRepo.watchLikedSongs(userId);
});

final historyStreamProvider = StreamProvider.autoDispose<List<HistoryEntry>>((ref) {
   final userId = ref.watch(authControllerProvider).valueOrNull?.id;
  if (userId == null) return Stream.value([]);
  final libraryRepo = ref.watch(libraryRepositoryProvider);
  return libraryRepo.watchHistory(userId, limit: 20);
});


class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  void _showCreatePlaylistDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController playlistNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final userId = ref.read(authControllerProvider).valueOrNull?.id;
    if (userId == null) {
      showSnackbar("Error", "You must be logged in to create a playlist.", isError: true);
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text("Create New Playlist"),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: playlistNameController,
            decoration: const InputDecoration(
              hintText: "Playlist Name",
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Playlist name cannot be empty.";
              }
              return null;
            },
          )
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(), 
              child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    final name = playlistNameController.text.trim();
                    Get.back();

                    try {
                      final libraryRepo = ref.read(libraryRepositoryProvider);
                      await libraryRepo.createPlaylist(userId, name);
                      showSnackbar("Success", "Playlist '$name' created.");
                    } catch (e) {
                      showSnackbar("Error", "Could not create playlist. $e", isError: true);
                    }
                  }
                }, 
                child: const Text("Create"),
                )
          ],
      )
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsStreamProvider);
    final likedSongsAsync = ref.watch(likedSongsStreamProvider);
    final historyAsync = ref.watch(historyStreamProvider);
    final textTheme = Theme.of(context).textTheme;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        automaticallyImplyLeading: false,
        actions: [ IconButton(icon: Icon(Icons.add_box_outlined),tooltip: "Create Playlist" ,onPressed: () => _showCreatePlaylistDialog(context, ref)) ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
            ref.invalidate(playlistsStreamProvider);
            ref.invalidate(likedSongsStreamProvider);
            ref.invalidate(historyStreamProvider);
            await Future.delayed(const Duration(milliseconds: 500));
         },
          child: ListView(
            children: [
             // --- Playlists Section ---
             Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
               child: Text("Playlists", style: textTheme.headlineSmall),
             ),
             playlistsAsync.when(
               data: (playlists) => playlists.isEmpty
                   ? const ListTile(dense: true, title: Text("No playlists yet. Tap '+' to create one."))
                   : Column(
                    children: playlists.map((playlist) => ListTile(
                       leading: const Icon(Icons.playlist_play),
                       title: Text(playlist.name),
                       onTap: () {
                        print("Tapped playlist: ${playlist.name} (ID: ${playlist.id})");
                        Get.toNamed(AppRoutes.player, arguments: playlist);
                       },
                       )).toList()),
               loading: () => const Center(child: Padding(padding: EdgeInsets.all(8.0), child: LoadingIndicator())),
               error: (err, st) => ListTile(title: Text("Error loading playlists: $err")),
             ),

             const Divider(),


             // --- Liked Songs Section ---
             likedSongsAsync.when(
                data: (likedSongs) => ListTile(
                   leading: const Icon(Icons.favorite),
                   title: Text("Liked Songs", style: textTheme.titleLarge),
                   subtitle: Text("${likedSongs.length} songs"),
                   onTap: () { print("Tapped Liked Songs"); },
                ),
                loading: () => const ListTile(title: Text("Liked Songs"), subtitle: Text("Loading...")),
                error: (err, st) => ListTile(title: Text("Liked Songs"), subtitle: Text("Error: $err")),
             ),

              const Divider(),


             // --- History Section ---
             Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
               child: Text("Recently Played", style: textTheme.headlineSmall),
             ),
             historyAsync.when(
               data: (history) => history.isEmpty
                 ? const ListTile(dense: true, title: Text("No playback history yet."))
                 : Column(
                     children: history.map((entry) {
                        final track = model_track.Track(
                           id: entry.trackId,
                           title: entry.trackTitle,
                           artist: entry.trackArtist,
                           thumbnailPath: entry.trackThumbnailPath,
                           duration: entry.trackDurationSeconds != null ? Duration(seconds: entry.trackDurationSeconds!) : null,
                        );
                   return TrackListItem(track: track, onTap: () {
                      // TODO: Play track from history
                       print("Tapped history: ${track.title}");
                   });
                     }).toList(),
                   ),
               loading: () => const Center(child: Padding(padding: EdgeInsets.all(8.0), child: LoadingIndicator())),
               error: (err, st) => ListTile(title: Text("Error loading history: $err")),
             ),
             const SizedBox(height: 70), 
           ],
         ),
      ),
    );
  }
}