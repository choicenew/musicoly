import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadsSettings extends StatefulWidget {
  const DownloadsSettings({super.key});

  @override
  State<DownloadsSettings> createState() => _DownloadsSettingsState();
}

class _DownloadsSettingsState extends State<DownloadsSettings> {
  late String _downloadPath;
  late String _downloadFormat;
  late bool _downloadLyrics;
  late bool _downloadCover;
  late String _fileNamingFormat;
  
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() async {
      _downloadPath = prefs.getString('downloadPath') ?? 
        (await getDownloadsDirectory())?.path ?? 'C:/Downloads';
      _downloadFormat = prefs.getString('downloadFormat') ?? 'mp3';
      _downloadLyrics = prefs.getBool('downloadLyrics') ?? true;
      _downloadCover = prefs.getBool('downloadCover') ?? true;
      _fileNamingFormat = prefs.getString('fileNamingFormat') ?? 'artist_title';
    });
  }

  Future<void> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _selectDownloadPath() async {
    final path = await FilePicker.platform.getDirectoryPath();
    if (path != null) {
      setState(() => _downloadPath = path);
      await _saveString('downloadPath', path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 下载路径选择
            ListTile(
              title: const Text('下载路径'),
              subtitle: Text(_downloadPath),
              trailing: IconButton(
                icon: const Icon(Icons.folder_open),
                onPressed: _selectDownloadPath,
              ),
            ),
            // 下载格式选择
            ListTile(
              title: const Text('下载格式'),
              trailing: DropdownButton<String>(
                value: _downloadFormat,
                items: const [
                  DropdownMenuItem(value: 'mp3', child: Text('MP3')),
                  DropdownMenuItem(value: 'flac', child: Text('FLAC')),
                  DropdownMenuItem(value: 'wav', child: Text('WAV')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _downloadFormat = value);
                    _saveString('downloadFormat', value);
                  }
                },
              ),
            ),
            // 其他设置保持不变，增加状态管理...
            // 歌词下载开关
            SwitchListTile(
              title: const Text('下载歌词'),
              subtitle: const Text('同时下载歌曲的歌词文件'),
              value: _downloadLyrics,
              onChanged: (value) {
                setState(() => _downloadLyrics = value);
                _saveBool('downloadLyrics', value);
              },
            ),
            // 封面下载开关 
            SwitchListTile(
              title: const Text('下载封面'),
              subtitle: const Text('同时下载歌曲的封面图片'),
              value: _downloadCover,
              onChanged: (value) {
                setState(() => _downloadCover = value);
                _saveBool('downloadCover', value);
              },
            ),
            // 文件命名格式选择
            ListTile(
              title: const Text('文件命名格式'),
              subtitle: const Text('设置下载文件的命名规则'),
              trailing: DropdownButton<String>(
                value: _fileNamingFormat,
                items: const [
                  DropdownMenuItem(value: 'title', child: Text('歌曲名')),
                  DropdownMenuItem(
                    value: 'artist_title', 
                    child: Text('歌手 - 歌曲名'),
                  ),
                  DropdownMenuItem(
                    value: 'title_artist',
                    child: Text('歌曲名 - 歌手'),
                  ),
                  DropdownMenuItem(
                    value: 'album_track_title',
                    child: Text('专辑 - 曲目 - 歌曲名'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _fileNamingFormat = value);
                    _saveString('fileNamingFormat', value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
