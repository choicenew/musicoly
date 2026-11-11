import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/models/track_model.dart';

/// Finamp & Polaris Style Jellyfin / Emby / Subsonic Private Media Server Client
class PrivateServerService {
  String _serverUrl = '';
  String _username = '';
  String _token = '';
  bool _isConnected = false;

  bool get isConnected => _isConnected;
  String get serverUrl => _serverUrl;

  Future<bool> connectSubsonic({
    required String url,
    required String username,
    required String password,
  }) async {
    try {
      _serverUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
      _username = username;
      // 模拟 Subsonic / Jellyfin 鉴权连通性测试
      await Future.delayed(const Duration(milliseconds: 800));
      _token = 'subsonic_token_${DateTime.now().millisecondsSinceEpoch}';
      _isConnected = true;
      debugPrint('Connected to private media server: $_serverUrl');
      return true;
    } catch (e) {
      debugPrint('Failed to connect to private server: $e');
      _isConnected = false;
      return false;
    }
  }

  Future<List<TrackModel>> fetchServerTracks() async {
    if (!_isConnected) return [];
    // 模拟从私有服务器拉取无损音乐列表
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      TrackModel(
        id: 'subsonic_1',
        platform: 'subsonic',
        name: 'NAS Lossless Symphony No. 9',
        artistNames: ['Subsonic Audiophile'],
        albumName: 'Private Cloud Collection',
        durationMs: 320000,
        audioSources: [
          AudioSourceModel(
            sourceId: 'subsonic',
            url: '$_serverUrl/rest/stream?id=1&u=$_username&t=$_token',
            quality: 'Lossless',
            bitrate: 1411,
          ),
        ],
      ),
    ];
  }

  void disconnect() {
    _serverUrl = '';
    _username = '';
    _token = '';
    _isConnected = false;
  }
}
