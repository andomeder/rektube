import 'package:piped_client/piped_client.dart';
import 'package:rektube/configs/constants.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/utils/exceptions.dart';

class PipedRepository {
  final PipedClient _client;

  // Initialize client with the instance URL from constants
  PipedRepository() : _client = PipedClient(instance: pipedInstanceUrl);

  ///Searches for streams (videos) on Piped
  Future<List<Track>> searchStreams(String query) async {
    if (query.isEmpty) {
      return [];
    }

    print("PipedRepository: Searching for '$query'...");
    try {
      // Search for streams only
      final searchResults = await _client.search(query, PipedFilter.videos);
      final List<Track> tracks = [];

      for (final item in searchResults.items) {
        // Only process stream items that have necessary info
        if (item.type == PipedSearchItemStream) {
          try {
            tracks.add(Track.fromPipedSearchItem(item));
          } catch (e) {
            final streamItem = item as PipedSearchItemStream;
            print(
              "PipedRepository: Error converting SearchItem to Track: $e (Item: ${streamItem.title})",
            );
          }
        }
      }

      print(
        "PipedRepository: Found ${tracks.length} stream tracks for '$query'",
      );
      return tracks;
    } on PipedException catch (e) {
      print("PipedRepository: PipedClientException during search: $e");
      throw PipedException("Search failed: ${e.message}");
    } catch (e) {
      print("PipedRepository: Unexpected error during search: $e");
      throw NetworkException("An unexpected error occurred while searching.");
    }
  }

  /// Gets streaming data for a specific video ID.
  Future<PipedStreamResponse> getStreamInfo(String videoId) async {
    print("PipedRepository: Getting stream info for '$videoId'");
    try {
      final streamInfo = await _client.streams(videoId);
      print("PipedRepository: Received stream info for '$videoId'");
      return streamInfo;
    } on PipedException catch (e) {
      print("PipedRepository: PipedClientException getting stream info: $e");
      throw PipedException("Failed to get stream info: ${e.message}");
    } catch (e) {
      print("PipedRepository: Unexpected error getting stream info: $e");
      throw NetworkException(
        "An unexpected error occurred while getting stream info.",
      );
    }
  }

  /// Gets search suggestions for a query.
  Future<List<String>> getSuggestions(String query) async {
    if (query.isEmpty) return [];
    print("PipedRepository: Getting suggestions for '$query'");
    try {
      final uri = Uri.parse(
        '$_client.instance/suggestions',
      ).replace(queryParameters: {'query': query});
      final response = await _client.client.getUri(uri);
      return (response.data as List).cast<String>();
    } on PipedException catch (e) {
      print("PipedRepository: PipedClientException getting suggestions: $e");
      throw PipedException("Failed to get suggestions: ${e.message}");
    } catch (e) {
      print("PipedRepository: Unexpected error getting suggestions: $e");
      throw NetworkException(
        "An unexpected error occurred while getting suggestions.",
      );
    }
  }

  /// Gets trending videos based on region (e.g., 'GB', 'US').
  Future<List<Track>> getTrending({String region = 'US'}) async {
    try {
      final uri = Uri.parse(
        '$_client.instance/trending',
      ).replace(queryParameters: {'region': region});
      final response = await _client.client.getUri(uri);

      final data =
          (response.data as List<dynamic>).cast<Map<String, dynamic>>();

      return data.map((item) => Track.fromJson(item)).toList();
    } on PipedException catch (e) {
      throw PipedException("Failed to get trending: ${e.message}");
    } catch (e) {
      throw NetworkException("Unexpected error getting trending videos.");
    }
  }
}
