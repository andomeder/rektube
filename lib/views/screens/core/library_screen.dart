// lib/views/screens/core/library_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/controllers/auth/auth_controller.dart'; // To get user ID
import 'package:rektube/database/database.dart'; // Import data classes
import 'package:rektube/models/track.dart' as model_track;
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';
import 'package:rektube/views/widgets/core/track_list_item.dart';
// Import other widgets as needed (e.g., TrackListItem)


// Individual StreamProviders for each section
final playlistsStreamProvider = StreamProvider.autoDispose<List<Playlist>>((ref) {
  final userId = ref.watch(authControllerProvider).valueOrNull?.id;
  if (userId == null) return Stream.value([]); // Return empty stream if not logged in
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
  // You can adjust the limit here if needed
  return libraryRepo.watchHistory(userId, limit: 20);
});


class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch individual stream providers
    final playlistsAsync = ref.watch(playlistsStreamProvider);
    final likedSongsAsync = ref.watch(likedSongsStreamProvider);
    final historyAsync = ref.watch(historyStreamProvider);
    final textTheme = Theme.of(context).textTheme;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        automaticallyImplyLeading: false,
        // Optional: Add 'Create Playlist' button
        // actions: [ IconButton(icon: Icon(Icons.add), onPressed: () { /* TODO */ }) ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
            // Invalidate providers to force re-fetch (streams might auto-update though)
            ref.invalidate(playlistsStreamProvider);
            ref.invalidate(likedSongsStreamProvider);
            ref.invalidate(historyStreamProvider);
            // Give some time for providers to update if needed
            await Future.delayed(const Duration(milliseconds: 500));
         },
          // Use DefaultTabController or custom scrolling for sections
          child: ListView( // Simple list for now
            children: [
             // --- Playlists Section ---
             Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
               child: Text("Playlists", style: textTheme.headlineSmall),
             ),
             playlistsAsync.when(
               data: (playlists) => playlists.isEmpty
                   ? const ListTile(dense: true, title: Text("No playlists yet."))
                   : Column(children: playlists.map((playlist) => ListTile( /* ... */ )).toList()),
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
                 : Column( // Use Column to avoid nested ListViews
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
             const SizedBox(height: 70), // Padding at bottom for mini player
           ],
         ),
      ),
    );
  }
}