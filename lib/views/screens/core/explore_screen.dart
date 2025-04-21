import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';
import 'package:rektube/views/widgets/core/track_list_item.dart';

//Provider to hold the search results state
final searchResultsProvider = StateProvider<AsyncValue<List<Track>>>((ref) {
  // Default to an empty data state
  return const AsyncValue.data([]);
});

// Provider to hold the current search query state
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
    // Optional: Load trending on initial load?
    // Future.microtask(() => _fetchTrending());

    // Sync text field with state provider if needed elsewhere
    _searchController.text = ref.read(searchQueryProvider);
    _searchController.addListener(() {
      // Optional: update searchQueryProvider on change for suggestions?
      //ref.read(searchQueryProvider.notifier).state = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _perfomSearch(String query) async {
    if (query.isEmpty) {
      ref.read(searchResultsProvider.notifier).state = const AsyncValue.data(
        [],
      );
      return;
    }

    //Update query state
    ref.read(searchQueryProvider.notifier).state = query;

    //Set loading state for results
    ref.read(searchResultsProvider.notifier).state = const AsyncValue.loading();

    try {
      final repository = ref.read(pipedRepositoryProvider);
      final results = await repository.searchStreams(query);
      ref.read(searchResultsProvider.notifier).state = AsyncValue.data(results);
    } catch (error, stackTrace) {
      ref.read(searchResultsProvider.notifier).state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }

  // Fetch trending
  Future<void> _fetchTrending() async {
    ref.read(searchResultsProvider.notifier).state = const AsyncValue.loading();

    try {
      final repository = ref.read(pipedRepositoryProvider);
      final results = await repository.getTrending();
      ref.read(searchResultsProvider.notifier).state = AsyncValue.data(results);
    } catch (error, stackTrace) {
      ref.read(searchResultsProvider.notifier).state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search songs, artists...",
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, size: 20),
              onPressed: () {
                _searchController.clear();
                ref.read(searchQueryProvider.notifier).state = '';
                ref
                    .read(searchResultsProvider.notifier)
                    .state = const AsyncValue.data([]);
              },
            ),
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          onSubmitted: (query) => _perfomSearch(query),
          textInputAction: TextInputAction.search,
        ),
      ),
      body: Column(
        children: [
          // Search Results Area
          Expanded(
            child: searchResults.when(
              data: (tracks) {
                if (tracks.isEmpty && ref.watch(searchQueryProvider).isEmpty) {
                  return const Center(
                    child: Text("Enter search above or browse trending"),
                  );
                } else if (tracks.isEmpty &&
                    ref.watch(searchQueryProvider).isNotEmpty) {
                  return const Center(child: Text("No results found."));
                }
                // Display results
                return ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    final track = tracks[index];
                    return TrackListItem(
                      track: track,
                      onTap: () {
                        // TODO: Implement Playback (Phase 5)
                        print("Tapped on track: ${track.title}");
                        Get.snackbar("Info", "Playback not implemented yet.");
                      },
                    );
                  },
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
