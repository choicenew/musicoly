import 'package:meta/meta.dart';

@immutable
class LyricsEntity {
  final String id;
  final String trackId;
  final String plainText;
  final String? syncedLrc;
  final bool isSynced;

  const LyricsEntity({
    required this.id,
    required this.trackId,
    required this.plainText,
    this.syncedLrc,
    this.isSynced = false,
  });
}
