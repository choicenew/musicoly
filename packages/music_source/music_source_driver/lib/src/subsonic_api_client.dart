import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:music_source_protocol/music_source_protocol.dart';

/// Finamp & Polaris Inspired Production Subsonic / Jellyfin API Client
class SubsonicApiClient {
  String _serverUrl = '';
  String _username = '';
  String _password = '';
  String _token = '';
  String _salt = '';
  bool _isConnected = false;

  bool get isConnected => _isConnected;
  String get serverUrl => _serverUrl;

  /// 计算 Subsonic Token & Salt 哈希鉴权 (Subsonic API Protocol Spec v1.13+)
  void _generateAuthToken(String password) {
    final saltBytes = DateTime.now().millisecondsSinceEpoch.toString();
    _salt = saltBytes;
    final combo = '$password$_salt';
    _token = md5.convert(utf8.encode(combo)).toString();
  }

  /// 连接并验证 Subsonic / Jellyfin 服务器
  Future<bool> connect({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    _serverUrl = serverUrl.endsWith('/') ? serverUrl.substring(0, serverUrl.length - 1) : serverUrl;
    _username = username;
    _password = password;
    _generateAuthToken(password);

    try {
      final uri = Uri.parse('$_serverUrl/rest/ping.view?u=$_username&t=$_token&s=$_salt&v=1.16.1&c=Musicoly&f=json');
      final response = await http.get(uri).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['subsonic-response']?['status'];
        if (status == 'ok') {
          _isConnected = true;
          debugPrint('Subsonic server connected: $_serverUrl (User: $_username)');
          return true;
        }
      }
    } catch (e) {
      debugPrint('Subsonic connection error: $e');
    }

    _isConnected = false;
    return false;
  }

  /// 获取服务器歌曲流 URL (含转码及码率参数)
  String getStreamUrl(String songId, {int maxBitrate = 320}) {
    return '$_serverUrl/rest/stream.view?id=$songId&u=$_username&t=$_token&s=$_salt&v=1.16.1&c=Musicoly&maxBitRate=$maxBitrate';
  }

  /// 获取服务器专辑封面 URL
  String getCoverArtUrl(String coverId, {int size = 300}) {
    return '$_serverUrl/rest/getCoverArt.view?id=$coverId&u=$_username&t=$_token&s=$_salt&v=1.16.1&c=Musicoly&size=$size';
  }

  /// 获取服务器歌曲搜索结果 (`search3.view`)
  Future<List<TrackEntity>> searchServer(String query) async {
    if (!_isConnected) return [];

    try {
      final uri = Uri.parse('$_serverUrl/rest/search3.view?query=${Uri.encodeComponent(query)}&u=$_username&t=$_token&s=$_salt&v=1.16.1&c=Musicoly&f=json');
      final response = await http.get(uri).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final songs = data['subsonic-response']?['searchResult3']?['song'] as List<dynamic>? ?? [];

        return songs.map((s) {
          final id = s['id'].toString();
          final durationSec = (s['duration'] as num?)?.toInt() ?? 0;

          return TrackEntity(
            id: id,
            platform: 'subsonic',
            name: s['title'] ?? 'Unknown Subsonic Track',
            artistNames: [s['artist'] ?? 'Unknown Artist'],
            albumName: s['album'],
            durationMs: durationSec * 1000,
            imageUrl: s['coverArt'] != null ? getCoverArtUrl(s['coverArt']) : null,
          );
        }).toList();
      }
    } catch (e) {
      debugPrint('Subsonic search error: $e');
    }
    return [];
  }
}
