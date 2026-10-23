import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/track_model.dart';

/// A reusable widget for displaying a track item in lists
class TrackTile extends StatelessWidget {
  /// The track data to display
  final TrackModel track;

  /// Callback when the track is tapped
  final VoidCallback? onTap;

  /// Callback when the track is played
  final VoidCallback? onPlay;

  /// Whether this track is currently playing
  final bool isPlaying;

  /// Whether to show the album art
  final bool showAlbumArt;

  /// Whether to show artist name
  final bool showArtist;

  /// Whether to show album name
  final bool showAlbum;

  /// Whether to show track duration
  final bool showDuration;

  /// Whether to show track options menu
  final bool showOptions;

  const TrackTile({
    super.key,
    required this.track,
    this.onTap,
    this.onPlay,
    this.isPlaying = false,
    this.showAlbumArt = true,
    this.showArtist = true,
    this.showAlbum = false,
    this.showDuration = true,
    this.showOptions = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      selected: isPlaying,
      selectedTileColor: theme.colorScheme.primaryContainer.withAlpha(0x33),
      leading: showAlbumArt ? _buildLeading() : null,
      title: Text(
        track.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
          color: isPlaying ? theme.colorScheme.primary : null,
        ),
      ),
      subtitle: showArtist ? _buildSubtitle() : null,
      trailing: _buildTrailing(),
    );
  }

  Widget _buildLeading() {
    return SizedBox(
      width: 48,
      height: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          track.imageUrl ?? 'assets/album-placeholder.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Image.asset(
            'assets/album-placeholder.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    final artistNames = track.artistNames.join(', ');
    final albumName = track.albumName;

    if (showAlbum) {
      return Text(
        '$artistNames • $albumName',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return Text(
      artistNames,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDuration)
          Text(_formatDuration(Duration(milliseconds: track.durationMs))),
        if (showOptions)
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show track options menu
            },
          ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
