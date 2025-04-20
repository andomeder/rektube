import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String? thumbnailUrl;
  final Duration? duration;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    this.thumbnailUrl,
    this.duration,
  });

  // TODO:  Add factory constructors later to parse from Piped API responses
  
  
  @override
  List<Object?> get props => [id, title, artist, thumbnailUrl, duration];
}