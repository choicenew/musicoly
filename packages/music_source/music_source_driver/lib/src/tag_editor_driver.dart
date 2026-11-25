import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:metadata_god/metadata_god.dart';

/// RetroMusic & Fossify Music Style Local Audio ID3 Tag Editor
class TagEditorDriver {
  /// 读取本地音频文件的完整 ID3v2 元数据
  Future<Metadata?> readMetadata(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return null;
      return await MetadataGod.readMetadata(file: filePath);
    } catch (e) {
      debugPrint('Error reading ID3 metadata: $e');
      return null;
    }
  }

  /// 写入更新本地音频文件的 ID3 标签 (标题、歌手、专辑、发行年份及歌词)
  Future<bool> writeMetadata({
    required String filePath,
    String? title,
    String? artist,
    String? album,
    int? year,
    String? genre,
    String? lyrics,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return false;

      await MetadataGod.writeMetadata(
        file: filePath,
        metadata: Metadata(
          title: title,
          artist: artist,
          album: album,
          year: year,
          genre: genre,
        ),
      );
      debugPrint('Successfully written ID3 metadata to: $filePath');
      return true;
    } catch (e) {
      debugPrint('Error writing ID3 metadata: $e');
      return false;
    }
  }
}
