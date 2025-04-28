import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';
import 'package:rektube/views/widgets/core/track_list_item.dart';

final exploreContentProvider = StateProvider<AsyncValue<List<Track>>>((ref) {
  return const AsyncValue.loading();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.text = ref.read(searchQueryProvider);
    if (_searchController.text.isEmpty) {
      Future.microtask(() => _fetchTrending());
    } else {
      Future.microtask(() => _performSearch(_searchController.text));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      _fetchTrending();
      return;
    }

    ref.read(searchQueryProvider.notifier).state = query;

    //Set loading state for results
    ref.read(exploreContentProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final repository = ref.read(pipedRepositoryProvider);
      final results = await repository.searchStreams(query);
      ref.read(exploreContentProvider.notifier).state = AsyncValue.data(
        results,
      );
    } catch (error, stackTrace) {
      ref.read(exploreContentProvider.notifier).state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }

  // Fetch trending
  Future<void> _fetchTrending() async {
    ref.read(exploreContentProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final repository = ref.read(pipedRepositoryProvider);
      final results = await repository.getTrending();
      ref.read(exploreContentProvider.notifier).state = AsyncValue.data(
        results,
      );
    } catch (error, stackTrace) {
      ref.read(exploreContentProvider.notifier).state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final exploreContent = ref.watch(exploreContentProvider);
    bool isSearching = ref.watch(searchQueryProvider).isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search songs, artists...",
              border: InputBorder.none,
              isDense: true,
              prefixIcon: Icon(Icons.search_rounded),
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () {
                  _searchController.clear();
                  ref.read(searchQueryProvider.notifier).state = '';
                  ref
                      .read(exploreContentProvider.notifier)
                      .state = const AsyncValue.data([]);
                },
              ),
            ),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            onSubmitted: (query) => _performSearch(query),
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Results Area
          Expanded(
            child: exploreContent.when(
              data: (tracks) {
                // Show trending title only when not searching
                final title = isSearching ? "Search Results" : "Trending";
                if (tracks.isEmpty && isSearching) {
                  return const Center(child: Text("No results found."));
                } else if (tracks.isEmpty && !isSearching) {
                  return const Center(
                    child: Text("Could not load trending content."),
                  );
                }

                // Display results
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: tracks.length,
                        itemBuilder: (context, index) {
                          final track = tracks[index];
                          return TrackListItem(
                            track: track,
                            onTap: () {
                              print("Tapped on track: ${track.title}");
                              final playerController =
                                  Get.find<PlayerController>();
                              final currentList =
                                  ref.read(exploreContentProvider).value ?? [];
                              final tappedIndex = currentList.indexWhere(
                                (t) => t.id == track.id,
                              );
                              if (tappedIndex != -1) {
                                playerController.loadQueue(
                                  currentList,
                                  startIndex: tappedIndex,
                                );
                              } else {
                                playerController.play(track, ref);
                              }
                              // Get.snackbar("Playback", "Playing ${track.title}"); 
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                print("Explore Screen Error: $error\n$stackTrace");
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Error loading results: $error",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              loading: () => const Center(child: LoadingIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
