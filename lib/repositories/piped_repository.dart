import 'package:dio/dio.dart';
import 'package:piped_client/piped_client.dart';
import 'package:rektube/configs/constants.dart';
import 'package:rektube/models/track.dart';
import 'package:rektube/utils/exceptions.dart';

class PipedRepository {
  //final PipedClient _client;

  //final PipedClient _pipedClient = PipedClient(instance: pipedInstanceUrl);

  // Initialize client with the instance URL from constants
  //PipedRepository() : _client = PipedClient(instance: pipedInstanceUrl);

  final PipedClient _pipedClient = PipedClient(instance: pipedInstanceUrl);
  final Dio _dioClient;

  PipedRepository() : _dioClient = Dio() {
    _dioClient.interceptors.add(LogInterceptor(responseBody: true));
    _dioClient.options.baseUrl = _pipedClient.client.options.baseUrl;
  }


  Future<List<Track>> searchStreams(String query) async {
    if (query.isEmpty) {
      return [];
    }

    print("PipedRepository: Searching for '$query'...");
    try {
      final searchResults = await _pipedClient.search(query, PipedFilter.videos);
      final List<Track> tracks = [];

      for (final item in searchResults.items) {
        if (item is PipedSearchItemStream) {
          try {
            tracks.add(Track.fromPipedSearchItem(item));
          } catch (e) {
            print(
              "PipedRepository: Error converting SearchItem to Track: $e (Item: ${item.title})",
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

  // /// Gets streaming data for a specific video ID.
  // Future<PipedStreamResponse> getStreamInfo(String videoId) async {
  //   print("PipedRepository: Getting stream info for '$videoId'");
  //   try {
  //     final streamInfo = await _client.streams(videoId);
  //     print("PipedRepository: Received stream info for '$videoId'");
  //     return streamInfo;
  //   } on PipedException catch (e) {
  //     print("PipedRepository: PipedClientException getting stream info: $e");
  //     throw PipedException("Failed to get stream info: ${e.message}");
  //   } catch (e) {
  //     print("PipedRepository: Unexpected error getting stream info: $e");
  //     throw NetworkException(
  //       "An unexpected error occurred while getting stream info.",
  //     );
  //   }
  // }

  // Modify getStreamInfo to use direct Dio call to JSON endpoint
  Future<Map<String, dynamic>> getStreamInfoJson(String videoId) async {
    final url = '$pipedInstanceUrl/streams/$videoId'; // Target JSON endpoint
    print("PipedRepository: Getting stream info JSON from: $url");
    try {
      final response = await _dioClient.get(url);

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        print("PipedRepository: Successfully received stream info JSON for '$videoId'");
        return response.data as Map<String, dynamic>; 
      } else {
         print("PipedRepository: Received non-200 status or invalid data format for stream info. Status: ${response.statusCode}, Data: ${response.data}");
         throw PipedException("Failed to get valid stream info (Status: ${response.statusCode})");
      }
    } on DioException catch (e) {
      print("PipedRepository: DioException getting stream info JSON: ${e.response?.statusCode} - ${e.message}");
       String errorMessage = "Failed to get stream info.";
       if (e.response?.data is Map) {
          final errorData = e.response!.data as Map;
          if (errorData.containsKey('message')) {
             errorMessage += " Server message: ${errorData['message']}";
          } else if (errorData.containsKey('error')) {
             errorMessage += " Server error: ${errorData['error']}";
          }
       } else if (e.response?.statusCode != null) {
           errorMessage += " (Status: ${e.response?.statusCode})";
       } else {
           errorMessage += " (${e.type})";
       }
       throw PipedException(errorMessage);
    } catch (e, stackTrace) {
      print("PipedRepository: Unexpected error getting stream info JSON: $e\n$stackTrace");
      throw NetworkException("An unexpected error occurred fetching stream details.");
    }
  }

  /*
  /// Gets search suggestions for a query.
  Future<List<String>> getSuggestions(String query) async {
    if (query.isEmpty) return [];
    print("PipedRepository: Getting suggestions for '$query'");
    final url = '$pipedInstanceUrl/suggestions?query=${Uri.encodeComponent(query)}';
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

  */

  Future<List<String>> getSuggestions(String query) async {
       if (query.isEmpty) return [];
       final url = '$pipedInstanceUrl/suggestions?query=${Uri.encodeComponent(query)}';
       print("PipedRepository: Getting suggestions from URL: $url");
       try {
         final response = await _dioClient.get(url);
         if (response.data is List) {
           final suggestions = (response.data as List).map((item) => item.toString()).toList();
           print("PipedRepository: Received ${suggestions.length} suggestions");
           return suggestions;
         } else { return []; }
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

/*
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
*/


   Future<List<Track>> getTrending({String region = 'US'}) async {
       final url = '$pipedInstanceUrl/trending?region=${Uri.encodeComponent(region)}';
       print("PipedRepository: Getting trending from URL: $url");
       try {
         final response = await _dioClient.get(url);
         if (response.data is List) {
           final data = (response.data as List).cast<Map<String, dynamic>>();
           final List<Track> tracks = [];
           for (var itemMap in data) {
             try { tracks.add(Track.fromJson(itemMap)); }
             catch (e) { print("PipedRepository: Error converting trending item map to Track: $e"); }
           }
           print("PipedRepository: Parsed ${tracks.length} trending tracks");
           return tracks;
         } else { return []; }
       } on PipedException catch (e) {
      throw PipedException("Failed to get trending: ${e.message}");
    } catch (e) {
      throw NetworkException("Unexpected error getting trending videos.");
    }
   }


}
