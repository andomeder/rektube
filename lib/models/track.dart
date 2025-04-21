import 'package:equatable/equatable.dart';
import 'package:piped_client/piped_client.dart';
import 'package:rektube/utils/helpers.dart';

class Track extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String? _originalThumbnailUrl;
  final Duration? duration;
  final String? _originalUrl;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    String?thumbnailUrl,
    this.duration,
    String? url,
  }): _originalThumbnailUrl = thumbnailUrl,
        _originalUrl = url;

  String get thumbnailUrl => rewritePipedUrlForLocalDev(_originalThumbnailUrl);
  String get url => rewritePipedUrlForLocalDev(_originalUrl);

  factory Track.fromJson(Map<String, dynamic> json) {
    final rawUrl = json['url'] as String;

    final uri = Uri.parse(rawUrl);
    final videoId = uri.queryParameters['v'] ?? json['id'] as String? ?? 'unknown_id_${DateTime.now().millisecondsSinceEpoch}';

    return Track(
      id: videoId,
      title: json['title'] as String,
      artist: json['uploaderName'] as String,
      thumbnailUrl: json['thumbnail'] as String,
      duration: json['duration'] != null
          ? Duration(seconds: json['duration'] as int)
          : null, 
      url: rawUrl,
    );

  }

  // Factory constructor to create a Track from a Piped SearchItem (Stream type)
  factory Track.fromPipedSearchItem(PipedSearchItem item) {
    if (item.type != PipedSearchItemType.stream || item.url == null) {
      throw ArgumentError('SearchItem must be a stream type with a URL to be converted to a Track.');
    }

    final stream = item as PipedSearchItemStream;

    // Extract video ID from URL (e.g., /watch?v=VIDEO_ID)
    final uri = Uri.parse(stream.url!);
    final videoId = uri.queryParameters['v'];

    if (videoId == null) {
      throw ArgumentError('Could not extract video ID from URL: ${item.url}');
    }

    return Track(
      id: videoId,
      title: stream.title,
      artist: stream.uploaderName,
      thumbnailUrl: stream.thumbnail,
      duration: stream.duration,
      url: item.url,
    );
  }
  
  
  @override
  List<Object?> get props => [id, title, artist, thumbnailUrl, duration, url];
}