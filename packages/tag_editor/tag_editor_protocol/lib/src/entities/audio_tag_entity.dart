import 'package:flutter/foundation.dart';

@immutable
class AudioTagEntity {
  final String title;
  final String artist;
  final String album;
  final int year;
  final String genre;
  final String? artworkPath;

  const AudioTagEntity({
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.genre,
    this.artworkPath,
  });
}
