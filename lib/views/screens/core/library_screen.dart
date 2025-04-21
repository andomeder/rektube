// lib/views/screens/core/library_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/controllers/auth/auth_controller.dart'; // To get user ID
import 'package:rektube/database/database.dart'; // Import data classes
import 'package:rektube/models/track.dart' as ModelTrack;
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';
import 'package:rektube/views/widgets/core/track_list_item.dart';
// Import other widgets as needed (e.g., TrackListItem)

// Provider to fetch library data together (example)
final libraryDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final authState = ref.watch(authControllerProvider);
  final libraryRepo = ref.watch(libraryRepositoryProvider);
  final userId = authState.valueOrNull?.id;

  if (userId == null) {
    throw Exception("User not logged in"); // Or handle appropriately
  }

  // Fetch data in parallel
  final results = await Future.wait([
    libraryRepo.getUserPlaylists(userId),
    libraryRepo.getLikedSongs(userId),
    libraryRepo.getHistory(userId, limit: 20), // Limit history display initially
  ]);

  return {
    'playlists': results[0] as List<Playlist>,
    'likedSongs': results[1] as List<LikedSong>,
    'history': results[2] as List<HistoryEntry>,
  };
});


class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryDataAsync = ref.watch(libraryDataProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        automaticallyImplyLeading: false,
        // Optional: Add 'Create Playlist' button
        // actions: [ IconButton(icon: Icon(Icons.add), onPressed: () { /* TODO */ }) ],
      ),
      body: libraryDataAsync.when(
        data: (data) {
          final List<Playlist> playlists = data['playlists'];
          final List<LikedSong> likedSongs = data['likedSongs'];
          final List<HistoryEntry> history = data['history'];

          // Use DefaultTabController or custom scrolling for sections
          return ListView( // Simple list for now
            children: [
               // --- Playlists Section ---
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text("Playlists", style: textTheme.headlineSmall),
               ),
               if (playlists.isEmpty)
                  const ListTile(title: Text("No playlists yet."))
               else
                  ...playlists.map((playlist) => ListTile(
                     leading: const Icon(Icons.playlist_play),
                     title: Text(playlist.name),
                     // subtitle: Text("${playlist.itemCount ?? 0} songs"), // Need item count later
                     onTap: () {
                         // TODO: Navigate to PlaylistDetailsScreen
                         print("Tapped playlist: ${playlist.name}");
                     },
                  )),

               const Divider(),

               // --- Liked Songs Section ---
               ListTile(
                  leading: const Icon(Icons.favorite),
                  title: Text("Liked Songs", style: textTheme.titleLarge),
                  subtitle: Text("${likedSongs.length} songs"),
                  onTap: () {
                     // TODO: Navigate to a Liked Songs screen or show list
                     print("Tapped Liked Songs");
                  },
               ),
               // Optional: Show a few liked songs directly?
               // ...likedSongs.take(3).map((song) => TrackListItem(track: ..., onTap: ...)),

               const Divider(),

               // --- History Section ---
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                 child: Text("Recently Played", style: textTheme.headlineSmall),
               ),
               if (history.isEmpty)
                 const ListTile(title: Text("No playback history yet."))
               else
                 ...history.map((entry) {
                   // Convert HistoryEntry back to a Track model for TrackListItem
                   final track = ModelTrack.Track(
                     id: entry.trackId,
                     title: entry.trackTitle,
                     artist: entry.trackArtist,
                     thumbnailUrl: entry.trackThumbnailUrl,
                     duration: entry.trackDurationSeconds != null ? Duration(seconds: entry.trackDurationSeconds!) : null,
                   );
                   return TrackListItem(track: track, onTap: () {
                      // TODO: Play track from history
                       print("Tapped history: ${track.title}");
                   });
                 }),
                 const SizedBox(height: 70), // Padding at bottom for mini player
            ],
          );
        },
        loading: () => const Center(child: LoadingIndicator()),
        error: (error, stack) {
           print("Library Screen Error: $error\n$stack");
           return Center(child: Text("Error loading library: $error"));
        },
      ),
    );
  }
}