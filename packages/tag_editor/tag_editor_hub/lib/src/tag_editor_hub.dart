import 'package:tag_editor_driver/tag_editor_driver.dart';
import 'package:tag_editor_protocol/tag_editor_protocol.dart';

class TagEditorHub {
  final Id3TagDriver _driver = Id3TagDriver();

  Future<AudioTagEntity?> getTags(String filePath) => _driver.readTags(filePath);

  Future<bool> saveTags(String filePath, AudioTagEntity tags) => _driver.writeTags(filePath, tags);
}
