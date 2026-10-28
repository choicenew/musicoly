import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/core/database/isar/entities/track_entity.dart';
import 'package:pyro_music/core/database/isar/entities/playlist_entity.dart';
import 'package:pyro_music/core/database/isar/entities/lyrics_entity.dart';
import 'package:get_it/get_it.dart';

class BackupService extends BaseService {
  @override
  String get serviceId => 'backup_service';

  @override
  String get serviceName => 'Backup & Restore Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  Future<void> exportBackup() async {
    final isar = GetIt.instance<Isar>();
    
    // 导出数据为 JSON
    final tracks = await isar.trackEntitys.where().findAll();
    final playlists = await isar.playlistEntitys.where().findAll();
    final lyrics = await isar.lyricsEntitys.where().findAll();
    
    final data = {
      'version': serviceVersion,
      'exportDate': DateTime.now().toIso8601String(),
      'tracks': tracks.map((t) => {
        'trackId': t.trackId,
        'name': t.name,
        'artistNames': t.artistNames,
        'albumName': t.albumName,
        'durationMs': t.durationMs,
        'imageUrl': t.imageUrl,
        'localPath': t.localPath,
        'playCount': t.playCount,
        'lastPlayedAt': t.lastPlayedAt?.toIso8601String(),
      }).toList(),
      'playlists': playlists.map((p) => {
        'playlistId': p.playlistId,
        'name': p.name,
        'description': p.description,
        'imageUrl': p.imageUrl,
        'trackIds': p.trackIds,
      }).toList(),
      'lyrics': lyrics.map((l) => {
        'lyricsId': l.lyricsId,
        'trackId': l.trackId,
        'content': l.content,
        'isSynced': l.isSynced,
        'language': l.language,
        'source': l.source,
      }).toList(),
    };

    final jsonString = jsonEncode(data);
    
    // 选择保存位置
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'pyromusic_backup_${DateTime.now().millisecondsSinceEpoch}.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (outputFile != null) {
      final file = File(outputFile);
      await file.writeAsString(jsonString);
    }
  }

  Future<void> importBackup() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final jsonString = await file.readAsString();
      final data = jsonDecode(jsonString);

      if (data['version'] == null) {
        throw Exception('Invalid backup file');
      }

      final isar = GetIt.instance<Isar>();
      
      await isar.writeTxn(() async {
        // 导入曲目
        final List tracksData = data['tracks'] ?? [];
        for (final t in tracksData) {
          final track = TrackEntity()
            ..trackId = t['trackId']
            ..name = t['name']
            ..artistNames = List<String>.from(t['artistNames'] ?? [])
            ..albumName = t['albumName']
            ..durationMs = t['durationMs'] ?? 0
            ..imageUrl = t['imageUrl']
            ..localPath = t['localPath']
            ..playCount = t['playCount'] ?? 0
            ..lastPlayedAt = t['lastPlayedAt'] != null ? DateTime.parse(t['lastPlayedAt']) : null;
          
          await isar.trackEntitys.put(track);
        }

        // 导入歌单
        final List playlistsData = data['playlists'] ?? [];
        for (final p in playlistsData) {
          final playlist = PlaylistEntity()
            ..playlistId = p['playlistId']
            ..name = p['name']
            ..description = p['description']
            ..imageUrl = p['imageUrl']
            ..trackIds = List<String>.from(p['trackIds'] ?? []);
          
          await isar.playlistEntitys.put(playlist);
        }

        // 导入歌词
        final List lyricsData = data['lyrics'] ?? [];
        for (final l in lyricsData) {
          final lyric = LyricsEntity()
            ..lyricsId = l['lyricsId']
            ..trackId = l['trackId']
            ..content = l['content']
            ..isSynced = l['isSynced'] ?? false
            ..language = l['language']
            ..source = l['source'];
          
          await isar.lyricsEntitys.put(lyric);
        }
      });
    }
  }
}
