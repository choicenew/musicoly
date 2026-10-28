abstract class TrackInterface {
  String get id;
  String get platform;
  String get name;
  String? get imageUrl;
  List<String> get artistIds;
  List<String> get artistNames;
  String? get albumId;
  String? get albumName;
  int get durationMs;
  bool get isPlayable;
  String? get localPath;
  bool get isFavorite;
}
