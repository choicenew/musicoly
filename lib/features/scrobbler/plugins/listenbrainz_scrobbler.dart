import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/services/base_service.dart';

/// ListenBrainz Scrobbler 插件实现
class ListenbrainzScrobbler extends BaseService {
  bool _enabled = true;
  String? _userToken;
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.listenbrainz.org/1/',
    headers: {'Content-Type': 'application/json'},
  ));
  final _storage = const FlutterSecureStorage();

  @override
  String get serviceId => 'listenbrainz';

  @override
  String get serviceName => 'ListenBrainz';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => 'listenbrainz';

  bool get isEnabled => _enabled;
  bool get isAuthenticated => _userToken != null && _userToken!.isNotEmpty;

  @override
  Future<void> initialize() async {
    _userToken = await _storage.read(key: 'listenbrainz_user_token');
    debugPrint('ListenBrainz Scrobbler 初始化: ${isAuthenticated ? "已配置 User Token" : "未配置 Token"}');
  }

  Future<void> setUserToken(String token) async {
    _userToken = token.trim();
    await _storage.write(key: 'listenbrainz_user_token', value: _userToken);
  }

  Future<void> logout() async {
    _userToken = null;
    await _storage.delete(key: 'listenbrainz_user_token');
  }

  Future<void> onNowPlaying(TrackModel track) async {
    if (!isEnabled || !isAuthenticated) return;

    try {
      final payload = {
        'listen_type': 'playing_now',
        'payload': [
          {
            'track_metadata': {
              'artist_name': track.artistNames.join(', '),
              'track_name': track.name,
              if (track.albumName != null) 'release_name': track.albumName,
              'additional_info': {
                'media_player': 'Pyro Music',
                'submission_client': 'Pyro Music',
              },
            },
          }
        ],
      };

      await _dio.post(
        'submit-listens',
        data: payload,
        options: Options(headers: {'Authorization': 'Token $_userToken'}),
      );
    } catch (e) {
      debugPrint('ListenBrainz NowPlaying 失败: $e');
    }
  }

  Future<void> onScrobble(TrackModel track, {required int duration, required bool isComplete}) async {
    if (!isEnabled || !isAuthenticated) return;

    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final payload = {
        'listen_type': 'single',
        'payload': [
          {
            'listened_at': timestamp,
            'track_metadata': {
              'artist_name': track.artistNames.join(', '),
              'track_name': track.name,
              if (track.albumName != null) 'release_name': track.albumName,
              'additional_info': {
                'media_player': 'Pyro Music',
                'submission_client': 'Pyro Music',
                'duration_ms': duration,
              },
            },
          }
        ],
      };

      await _dio.post(
        'submit-listens',
        data: payload,
        options: Options(headers: {'Authorization': 'Token $_userToken'}),
      );
    } catch (e) {
      debugPrint('ListenBrainz Scrobble 失败: $e');
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
        'hasToken': isAuthenticated,
      };

  @override
  List<Type> getDependencies() => [];

  @override
  ServiceStatus getStatus() =>
      isAuthenticated ? ServiceStatus.available : ServiceStatus.notConfigured;
}
