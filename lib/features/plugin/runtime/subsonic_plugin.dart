import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:pyro_music/features/plugin/contracts/plugin_port_contracts.dart';
import 'package:pyro_music/features/plugin/entities/media_entity.dart';

/// Subsonic / Navidrome Self-Hosted Music Server Plugin
class SubsonicPlugin implements UniversalPluginPort {
  String _serverUrl = '';
  String _username = '';
  String _password = '';
  String _apiVersion = '1.16.1';
  String _clientName = 'pyro_music';

  @override
  PluginManifest get manifest => const PluginManifest(
        id: 'org.pyromusic.subsonic',
        name: 'Navidrome / Subsonic Server',
        version: '1.0.0',
        description: 'Self-hosted Subsonic & Navidrome music server client',
        baseUrl: 'http://localhost:4533',
        capabilities: {
          PluginCapability.explore,
          PluginCapability.search,
          PluginCapability.stream,
          PluginCapability.details,
          PluginCapability.lyrics,
          PluginCapability.scrobble,
        },
        isNsfw: false,
        riskLevel: 'safe',
      );

  @override
  Future<void> init(Map<String, dynamic> context) async {
    _serverUrl = context['serverUrl'] as String? ?? '';
    _username = context['username'] as String? ?? '';
    _password = context['password'] as String? ?? '';
  }

  @override
  List<Map<String, dynamic>> getConfigSchema() => [
        {
          'key': 'serverUrl',
          'type': 'text',
          'label': 'Subsonic Server URL (e.g. http://192.168.1.10:4533)',
          'default': '',
        },
        {
          'key': 'username',
          'type': 'text',
          'label': 'Username',
          'default': '',
        },
        {
          'key': 'password',
          'type': 'password',
          'label': 'Password',
          'default': '',
        },
      ];

  Map<String, String> _buildSubsonicParams() {
    final salt = DateTime.now().millisecondsSinceEpoch.toString();
    final token = md5.convert(utf8.encode('$_password$salt')).toString();

    return {
      'u': _username,
      't': token,
      's': salt,
      'v': _apiVersion,
      'c': _clientName,
      'f': 'json',
    };
  }

  Uri _buildUri(String path, [Map<String, String>? extraParams]) {
    final cleanServer = _serverUrl.endsWith('/')
        ? _serverUrl.substring(0, _serverUrl.length - 1)
        : _serverUrl;
    final params = {..._buildSubsonicParams(), ...?extraParams};
    return Uri.parse('$cleanServer/rest/$path').replace(queryParameters: params);
  }

  @override
  Future<List<HomeSectionEntity>> fetchExploreSections() async {
    if (_serverUrl.isEmpty) return [];

    try {
      final uri = _buildUri('getAlbumList.view', {'type': 'frequent', 'size': '10'});
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final albums = data['subsonic-response']?['albumList']?['album'] as List? ?? [];

        final items = albums.map((a) {
          final id = a['id'] as String;
          final title = a['title'] as String? ?? 'Unknown Album';
          final artist = a['artist'] as String? ?? 'Unknown Artist';
          final coverArt = a['coverArt'] as String?;

          return MediaEntity(
            id: id,
            title: title,
            type: MediaType.album,
            creators: CreatorsMatrix(singer: artist),
            thumbUrl: coverArt != null ? _buildUri('getCoverArt.view', {'id': coverArt}).toString() : '',
            coverUrl: coverArt != null ? _buildUri('getCoverArt.view', {'id': coverArt}).toString() : '',
            isCollection: true,
          );
        }).toList();

        return [
          HomeSectionEntity(
            id: 'subsonic_frequent',
            title: 'Navidrome Top Played',
            subtitle: 'Most played albums from your server',
            type: HomeSectionType.carousel,
            items: items,
          )
        ];
      }
    } catch (_) {}

    return [];
  }

  @override
  Future<List<MediaEntity>> exploreCategory(String categoryId, {int page = 1, int limit = 20}) async {
    return [];
  }

  @override
  Future<List<MediaEntity>> search(
    String query, {
    int page = 1,
    int limit = 20,
    List<MediaType>? types,
  }) async {
    if (_serverUrl.isEmpty || query.isEmpty) return [];

    try {
      final uri = _buildUri('search3.view', {
        'query': query,
        'songCount': limit.toString(),
      });
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final songs = data['subsonic-response']?['searchResult3']?['song'] as List? ?? [];

        return songs.map((s) {
          final id = s['id'] as String;
          final title = s['title'] as String? ?? 'Unknown Track';
          final artist = s['artist'] as String? ?? 'Unknown Artist';
          final album = s['album'] as String?;
          final duration = (s['duration'] as num?)?.toInt() ?? 0;
          final coverArt = s['coverArt'] as String?;

          return MediaEntity(
            id: id,
            title: title,
            type: MediaType.music,
            creators: CreatorsMatrix(singer: artist),
            album: album,
            durationSeconds: duration,
            thumbUrl: coverArt != null ? _buildUri('getCoverArt.view', {'id': coverArt}).toString() : '',
            coverUrl: coverArt != null ? _buildUri('getCoverArt.view', {'id': coverArt}).toString() : '',
          );
        }).toList();
      }
    } catch (_) {}

    return [];
  }

  @override
  Future<AudioStreamInfo> resolveAudioStream(
    String trackId, {
    String? preferredQuality,
    String? preferredCodec,
  }) async {
    if (_serverUrl.isEmpty) {
      return AudioStreamInfo(url: trackId);
    }

    final streamUri = _buildUri('stream.view', {'id': trackId});
    return AudioStreamInfo(
      url: streamUri.toString(),
      quality: preferredQuality ?? 'high',
    );
  }

  @override
  Future<MediaEntity> getDetail(String contentId) async {
    return MediaEntity(
      id: contentId,
      title: 'Subsonic Detail',
      type: MediaType.music,
    );
  }

  @override
  Future<String?> fetchLyrics(String trackId, {String? title, String? artist}) async {
    if (_serverUrl.isEmpty) return null;

    try {
      final uri = _buildUri('getLyrics.view', {
        if (artist != null) 'artist': artist,
        if (title != null) 'title': title,
      });
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['subsonic-response']?['lyrics']?['value'] as String?;
      }
    } catch (_) {}

    return null;
  }

  @override
  Future<bool> scrobble(String contentId, Map<String, dynamic> payload) async {
    if (_serverUrl.isEmpty) return false;

    try {
      final uri = _buildUri('scrobble.view', {
        'id': contentId,
        'submission': 'true',
      });
      final res = await http.get(uri);
      return res.statusCode == 200;
    } catch (_) {}

    return false;
  }

  @override
  Future<bool> push(String contentId, Map<String, dynamic> payload) async {
    return true;
  }
}
