import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/local_music/providers/local_scanner_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class DownloadsSettings extends ConsumerStatefulWidget {
  const DownloadsSettings({super.key});

  @override
  ConsumerState<DownloadsSettings> createState() => _DownloadsSettingsState();
}

class _DownloadsSettingsState extends ConsumerState<DownloadsSettings> {
  String _downloadPath = '';
  String _downloadFormat = 'mp3';
  bool _downloadLyrics = true;
  bool _downloadCover = true;
  String _fileNamingFormat = 'artist_title';
  
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final downloadsDir = await getDownloadsDirectory();
    setState(() {
      _downloadPath = prefs.getString('downloadPath') ?? 
        downloadsDir?.path ?? 'C:/Downloads';
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
    final l10n = AppLocalizations.of(context);
    final isScanning = ref.watch(localScannerProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(l10n.local_music),
              subtitle: Text(isScanning ? l10n.scanning : l10n.scan_local_music),
              trailing: isScanning 
                ? const SizedBox(
                    width: 24, 
                    height: 24, 
                    child: CircularProgressIndicator(strokeWidth: 2)
                  )
                : const Icon(Icons.refresh),
              onTap: isScanning ? null : () async {
                await ref.read(localScannerProvider.notifier).scan();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.scan_completed))
                  );
                }
              },
            ),
            const Divider(),
            ListTile(
              title: Text(l10n.download_path),
              subtitle: Text(_downloadPath),
              trailing: IconButton(
                icon: const Icon(Icons.folder_open),
                onPressed: _selectDownloadPath,
              ),
            ),
            ListTile(
              title: Text(l10n.download_format),
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
            SwitchListTile(
              title: Text(l10n.download_lyrics),
              subtitle: Text(l10n.download_lyrics_description),
              value: _downloadLyrics,
              onChanged: (value) {
                setState(() => _downloadLyrics = value);
                _saveBool('downloadLyrics', value);
              },
            ),
            SwitchListTile(
              title: Text(l10n.download_cover),
              subtitle: Text(l10n.download_cover_description),
              value: _downloadCover,
              onChanged: (value) {
                setState(() => _downloadCover = value);
                _saveBool('downloadCover', value);
              },
            ),
            ListTile(
              title: Text(l10n.file_naming_format),
              subtitle: Text(l10n.file_naming_format_description),
              trailing: DropdownButton<String>(
                value: _fileNamingFormat,
                items: [
                  DropdownMenuItem(value: 'title', child: Text(l10n.song_title)),
                  DropdownMenuItem(
                    value: 'artist_title', 
                    child: Text(l10n.artist_song_title),
                  ),
                  DropdownMenuItem(
                    value: 'title_artist',
                    child: Text(l10n.song_title_artist),
                  ),
                  DropdownMenuItem(
                    value: 'album_track_title',
                    child: Text(l10n.album_track_song_title),
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
