import 'package:meta/meta.dart';

@immutable
class QueueEntity {
  final List<String> trackIds;
  final int currentIndex;

  const QueueEntity({
    this.trackIds = const [],
    this.currentIndex = 0,
  });

  String? get currentTrackId =>
      (currentIndex >= 0 && currentIndex < trackIds.length) ? trackIds[currentIndex] : null;
}
