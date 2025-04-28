import 'package:equatable/equatable.dart';
import 'package:piped_client/piped_client.dart';
import 'package:rektube/utils/helpers.dart';

class Track extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String? thumbnailPath;
  final Duration? duration;
  final String? url;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    this.thumbnailPath,
    this.duration,
    this.url,
  });

  //String get thumbnailUrl => rewritePipedUrlForLocalDev(_originalThumbnailUrl);
  //String get url => rewritePipedUrlForLocalDev(_originalUrl);

  factory Track.fromJson(Map<String, dynamic> json) {
    final rawUrl = json['url'] as String;
    String? thumbnailPathOnly;
    final originalThumbnailUrl = json['thumbnail'] as String; 

    if (originalThumbnailUrl != null) {
      try {
        final thumbUri = Uri.parse(originalThumbnailUrl);
        thumbnailPathOnly = thumbUri.path + (thumbUri.hasQuery ? '?${thumbUri.query}' : '');
      } catch (_) {
        thumbnailPathOnly = null;
      }
    }
    final uri = rawUrl != null ? Uri.tryParse(rawUrl) : null;
    final videoId = uri?.queryParameters['v'] ?? json['id'] as String? ?? 'unknown_id_${DateTime.now().millisecondsSinceEpoch}';

    return Track(
      id: videoId,
      title: json['title'] as String? ?? 'Unknown Title',
      artist: json['uploaderName'] as String? ?? 'Unknown Artist',
      //thumbnailUrl: json['thumbnail'] as String,
      thumbnailPath: thumbnailPathOnly,
      duration: json['duration'] != null
          ? Duration(seconds: json['duration'] as int)
          : null, 
      url: rawUrl,
    );

  }


  factory Track.fromPipedSearchItem(PipedSearchItem item) {
    if (item.type != PipedSearchItemType.stream || item.url == null) {
      throw ArgumentError('SearchItem must be a stream type with a URL to be converted to a Track.');
    }

    final stream = item as PipedSearchItemStream;

    final uri = Uri.parse(stream.url!);
    final videoId = uri.queryParameters['v'];

    if (videoId == null) {
      throw ArgumentError('Could not extract video ID from URL: ${item.url}');
    }

    String? thumbnailPathOnly;
    if (stream.thumbnail != null) {
      try {
        final thumbUri = Uri.parse(stream.thumbnail!);
        thumbnailPathOnly = thumbUri.path + (thumbUri.hasQuery ? '?${thumbUri.query}' : '');
      } catch (_) {
        thumbnailPathOnly = null;
      }
    }

    return Track(
      id: videoId,
      title: stream.title,
      artist: stream.uploaderName,
      thumbnailPath: thumbnailPathOnly,
      duration: stream.duration,
      url: item.url,
    );
  }
  
  
  @override
  List<Object?> get props => [id, title, artist, thumbnailPath, duration, url];
}