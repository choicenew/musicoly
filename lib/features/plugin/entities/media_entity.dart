/// Media type discriminators
enum MediaType {
  music,
  audio,
  playlist,
  album,
  artist,
  video,
  homeSection,
}

/// Creators matrix specification
class CreatorsMatrix {
  final String? singer;
  final String? author;
  final String? voice;
  final String? composer;
  final String? painter;

  const CreatorsMatrix({
    this.singer,
    this.author,
    this.voice,
    this.composer,
    this.painter,
  });

  Map<String, String?> toMap() => {
        'singer': singer,
        'author': author,
        'voice': voice,
        'composer': composer,
        'painter': painter,
      };

  factory CreatorsMatrix.fromMap(Map<String, dynamic> map) {
    return CreatorsMatrix(
      singer: map['singer'] as String?,
      author: map['author'] as String?,
      voice: map['voice'] as String?,
      composer: map['composer'] as String?,
      painter: map['painter'] as String?,
    );
  }
}

/// Universal Media Entity DTO matching PyroMagma specification
class MediaEntity {
  final String id;
  final String title;
  final MediaType type;

  /// Creators Matrix
  final CreatorsMatrix creators;

  /// Image Resource Specification
  final String thumbUrl;
  final String coverUrl;

  /// Core URLs
  final String contentUrl;
  final String? mediaUrl;
  final Map<String, String>? httpHeaders;

  /// Domain Traits
  final String? album;
  final int? trackNumber;
  final int? durationSeconds;
  final String? lyrics;
  final String? quality;
  final String? codec;

  /// Collection Traits
  final bool isCollection;
  final String? parentId;
  final int? childrenCount;
  final List<MediaEntity>? children;

  /// Other Metadata
  final String? description;
  final List<String> tags;
  final String? publishDate;
  final Map<String, dynamic> extra;

  const MediaEntity({
    required this.id,
    required this.title,
    required this.type,
    this.creators = const CreatorsMatrix(),
    this.thumbUrl = '',
    this.coverUrl = '',
    this.contentUrl = '',
    this.mediaUrl,
    this.httpHeaders,
    this.album,
    this.trackNumber,
    this.durationSeconds,
    this.lyrics,
    this.quality,
    this.codec,
    this.isCollection = false,
    this.parentId,
    this.childrenCount,
    this.children,
    this.description,
    this.tags = const [],
    this.publishDate,
    this.extra = const {},
  });
}

/// Home Section Type
enum HomeSectionType {
  quickActions,
  trackList,
  carousel,
  grid,
  adBanner,
  adCard,
}

/// Home Section Entity
class HomeSectionEntity {
  final String id;
  final String title;
  final String? subtitle;
  final HomeSectionType type;
  final List<MediaEntity> items;
  final Map<String, dynamic> extra;

  const HomeSectionEntity({
    required this.id,
    required this.title,
    this.subtitle,
    required this.type,
    required this.items,
    this.extra = const {},
  });
}

/// Audio Stream Payload Entity
class AudioStreamInfo {
  final String url;
  final Map<String, String>? headers;
  final String? mimeType;
  final int? bitrate;
  final String? quality;
  final List<String> fallbackUrls;

  const AudioStreamInfo({
    required this.url,
    this.headers,
    this.mimeType,
    this.bitrate,
    this.quality,
    this.fallbackUrls = const [],
  });
}
