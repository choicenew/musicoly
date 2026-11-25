import 'package:flutter/material.dart';
import 'package:music_source_driver/music_source_driver.dart';

/// RetroMusicPlayer & Fossify Music Style Interactive Local Audio ID3 Tag Editor Dialog
class Id3TagEditorDialogUI extends StatefulWidget {
  final String filePath;
  final String initialTitle;
  final String initialArtist;
  final String? initialAlbum;

  const Id3TagEditorDialogUI({
    super.key,
    required this.filePath,
    required this.initialTitle,
    required this.initialArtist,
    this.initialAlbum,
  });

  @override
  State<Id3TagEditorDialogUI> createState() => _Id3TagEditorDialogUIState();
}

class _Id3TagEditorDialogUIState extends State<Id3TagEditorDialogUI> {
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _albumController;
  late TextEditingController _yearController;
  late TextEditingController _genreController;

  final TagEditorDriver _tagEditorDriver = TagEditorDriver();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _artistController = TextEditingController(text: widget.initialArtist);
    _albumController = TextEditingController(text: widget.initialAlbum ?? '');
    _yearController = TextEditingController();
    _genreController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    _yearController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  Future<void> _saveMetadata() async {
    setState(() => _isSaving = true);
    final success = await _tagEditorDriver.writeMetadata(
      filePath: widget.filePath,
      title: _titleController.text.trim(),
      artist: _artistController.text.trim(),
      album: _albumController.text.trim().isNotEmpty ? _albumController.text.trim() : null,
      year: int.tryParse(_yearController.text.trim()),
      genre: _genreController.text.trim().isNotEmpty ? _genreController.text.trim() : null,
    );

    if (mounted) {
      setState(() => _isSaving = false);
      Navigator.of(context).pop(success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(Icons.edit_note, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          const Text('修改 ID3 音频标签信息'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '歌曲标题 (Title)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _artistController,
              decoration: const InputDecoration(
                labelText: '演唱歌手 (Artist)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _albumController,
              decoration: const InputDecoration(
                labelText: '所属专辑 (Album)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '发行年份 (Year)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _genreController,
                    decoration: const InputDecoration(
                      labelText: '流派 (Genre)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _saveMetadata,
          child: _isSaving
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('保存修改'),
        ),
      ],
    );
  }
}
