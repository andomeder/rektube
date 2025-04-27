import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/models/track.dart';

class TrackListItem extends StatelessWidget {
  final Track track;
  final VoidCallback? onTap;

  const TrackListItem({
    super.key,
    required this.track,
    this.onTap,
  });

  //Helper to formart duration
  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$minutes:$seconds";
    }

    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      leading: SizedBox(
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: track.thumbnailPath != null ? Image.network(track.thumbnailPath!, fit: BoxFit.cover, loadingBuilder: (context, child, progress) {
            return progress == null ? child: const Center(
              child: SizedBox(width: 20, height: 200, child: CircularProgressIndicator(strokeWidth: 2,),),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(color: Colors.grey[800], child: const Icon(Icons.music_note_outlined, color: Colors.grey,));
          },) : Container(color: Colors.grey[800], child: const Icon(Icons.music_note_outlined, color: Colors.grey,)),
        ),
      ),
      title: Text(track.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      subtitle: Text(
        track.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium?.copyWith(color: colorHint),
      ),
      trailing: Text(
        _formatDuration(track.duration),
        style: textTheme.bodySmall?.copyWith(color: colorHint),
      ),
      onTap: onTap,
    );
  }
}