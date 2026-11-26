import 'package:tag_editor_protocol/tag_editor_protocol.dart';

class Id3TagDriver {
  Future<AudioTagEntity?> readTags(String filePath) async {
    return const AudioTagEntity(
      title: 'Sample Track',
      artist: 'Sample Artist',
      album: 'Sample Album',
      year: 2026,
      genre: 'Pop',
    );
  }

  Future<bool> writeTags(String filePath, AudioTagEntity tags) async {
    return true;
  }
}
