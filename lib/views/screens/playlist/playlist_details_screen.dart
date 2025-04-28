import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/database/database.dart';
import 'package:rektube/models/track.dart' as model_track;
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';
import 'package:rektube/views/widgets/core/track_list_item.dart';


final playlistItemsProvider = FutureProvider.autoDispose.family<List<PlaylistItem>, int>((ref, playlistId) async {
  final libraryRepo = ref.watch(libraryRepositoryProvider);
  return libraryRepo.getPlaylistItems(playlistId);
});
class PlaylistDetailsScreen extends ConsumerWidget {
  const PlaylistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Playlist playlist = Get.arguments as Playlist;

    final itemsAsync = ref.watch(playlistItemsProvider(playlist.id));
    final textTheme = Theme.of(context).textTheme;



    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
      ),
      body: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text("This playlist is empty"),);
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              final track = model_track.Track(
                id: item.trackId,
                title: item.trackTitle,
                artist: item.trackArtist,
                thumbnailPath: item.trackThumbnailPath,
                duration: item.trackDurationSeconds != null ? Duration(seconds: item.trackDurationSeconds!) : null,
              );

              return TrackListItem(track: track, onTap: () {
                print("Playing from playlist: ${track.title}");
                final playerController = Get.find<PlayerController>();
                playerController.play(track, ref);
              },);
            }
            );
        }, 
        error: (err, stack) {
          print("Error loading playlist items: $err\n$stack");
          return Center(child: Text("Error loading tracks: $err"));
        }, 
        loading: () => const Center(child: LoadingIndicator()),
        )
    );
  }
}