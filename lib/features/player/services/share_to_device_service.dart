import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pyro_music/core/models/track_model.dart';

/// Spotube Style Share-To-Device & Local Network Media Stream Sharing Service
class ShareToDeviceService {
  HttpServer? _localServer;
  int _port = 8080;

  bool get isServerRunning => _localServer != null;
  int get port => _port;

  /// 获取当前局域网 IP 地址
  Future<String?> getLocalIpAddress() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLinkLocal: false,
      );
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      debugPrint('Error getting local IP: $e');
    }
    return '127.0.0.1';
  }

  /// 启动局域网媒体与设备分享 HTTP 服务
  Future<String> startLocalShareServer(TrackModel currentTrack) async {
    await stopServer();
    try {
      _localServer = await HttpServer.bind(InternetAddress.anyIPv4, _port);
      _localServer!.listen((HttpRequest request) {
        request.response
          ..headers.contentType = ContentType.json
          ..write('''{
            "status": "playing",
            "trackId": "${currentTrack.id}",
            "title": "${currentTrack.name}",
            "artist": "${currentTrack.artistNames.join(', ')}",
            "album": "${currentTrack.albumName ?? ''}",
            "imageUrl": "${currentTrack.imageUrl ?? ''}"
          }''')
          ..close();
      });

      final ip = await getLocalIpAddress();
      return 'http://$ip:$_port/share';
    } catch (e) {
      debugPrint('Error starting local share server: $e');
      return 'http://127.0.0.1:$_port/share';
    }
  }

  /// 停止本地分享服务
  Future<void> stopServer() async {
    if (_localServer != null) {
      await _localServer!.close(force: true);
      _localServer = null;
    }
  }
}
