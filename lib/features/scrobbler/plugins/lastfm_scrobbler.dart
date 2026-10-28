import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pyro_music/core/config/scrobbler_config.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// Last.fm Scrobbler 插件实现
class LastfmScrobbler extends BaseService {
  bool _enabled = true;
  String? _sessionKey;
  String? _username;
  final _dio = Dio(BaseOptions(baseUrl: 'https://ws.audioscrobbler.com/2.0/'));
  final _storage = const FlutterSecureStorage();

  static const String _apiKey = ScrobblerConfig.lastfmApiKey;
  static const String _apiSecret = ScrobblerConfig.lastfmApiSecret;

  @override
  String get serviceId => 'lastfm';

  @override
  String get serviceName => 'Last.fm';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => 'lastfm';

  bool get isEnabled => _enabled;
  bool get isAuthenticated => _sessionKey != null;

  @override
  Future<void> initialize() async {
    _sessionKey = await _storage.read(key: 'lastfm_session_key');
    _username = await _storage.read(key: 'lastfm_username');
    debugPrint('Last.fm Scrobbler 初始化: ${isAuthenticated ? "已登录 ($_username)" : "未登录"}');
  }

  Future<void> authenticate() async {
    final authUrl = Uri.parse(
      'https://www.last.fm/api/auth/?api_key=$_apiKey&cb=pyromusic://auth/lastfm',
    );
    if (await canLaunchUrl(authUrl)) {
      await launchUrl(authUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> handleAuthToken(String token) async {
    try {
      final params = {
        'api_key': _apiKey,
        'method': 'auth.getSession',
        'token': token,
      };
      
      final sig = _generateSignature(params);
      params['api_sig'] = sig;
      params['format'] = 'json';

      final response = await _dio.get('', queryParameters: params);
      if (response.statusCode == 200) {
        final data = response.data['session'];
        _sessionKey = data['key'];
        _username = data['name'];
        
        await _storage.write(key: 'lastfm_session_key', value: _sessionKey);
        await _storage.write(key: 'lastfm_username', value: _username);
        
        debugPrint('Last.fm 登录成功: $_username');
      }
    } catch (e) {
      debugPrint('Last.fm 登录失败: $e');
    }
  }

  Future<void> logout() async {
    _sessionKey = null;
    _username = null;
    await _storage.delete(key: 'lastfm_session_key');
    await _storage.delete(key: 'lastfm_username');
  }

  Future<void> onNowPlaying(TrackModel track) async {
    if (!isEnabled || !isAuthenticated) return;

    try {
      final params = {
        'api_key': _apiKey,
        'method': 'track.updateNowPlaying',
        'artist': track.artistNames.join(", "),
        'track': track.name,
        'sk': _sessionKey!,
      };

      if (track.albumName != null) {
        params['album'] = track.albumName!;
      }

      final sig = _generateSignature(params);
      params['api_sig'] = sig;
      params['format'] = 'json';

      await _dio.post('', data: FormData.fromMap(params));
    } catch (e) {
      debugPrint('Last.fm NowPlaying 失败: $e');
    }
  }

  Future<void> onScrobble(TrackModel track, {required int duration, required bool isComplete}) async {
    if (!isEnabled || !isAuthenticated) return;

    try {
      final params = {
        'api_key': _apiKey,
        'method': 'track.scrobble',
        'artist[0]': track.artistNames.join(", "),
        'track[0]': track.name,
        'timestamp[0]': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
        'sk': _sessionKey!,
      };

      if (track.albumName != null) {
        params['album[0]'] = track.albumName!;
      }

      final sig = _generateSignature(params);
      params['api_sig'] = sig;
      params['format'] = 'json';

      await _dio.post('', data: FormData.fromMap(params));
    } catch (e) {
      debugPrint('Last.fm Scrobble 失败: $e');
    }
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
  }

  @override
  Future<void> dispose() async {
    _dio.close();
  }

  @override
  Map<String, dynamic> getConfig() => {
        'username': _username,
        'hasSession': _sessionKey != null,
      };

  @override
  List<Type> getDependencies() => [];

  @override
  ServiceStatus getStatus() =>
      isAuthenticated ? ServiceStatus.available : ServiceStatus.notConfigured;

  String _generateSignature(Map<String, String> params) {
    final sortedKeys = params.keys.toList()..sort();
    final buffer = StringBuffer();
    for (final key in sortedKeys) {
      buffer.write(key);
      buffer.write(params[key]);
    }
    buffer.write(_apiSecret);
    return md5.convert(utf8.encode(buffer.toString())).toString();
  }
}
