import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:pyro_music/core/base/models/track_model.dart';
import 'package:pyro_music/core/providers/local_scanner_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class TagEditorDialog extends ConsumerStatefulWidget {
  final TrackModel track;

  const TagEditorDialog({super.key, required this.track});

  @override
  ConsumerState<TagEditorDialog> createState() => _TagEditorDialogState();
}

class _TagEditorDialogState extends ConsumerState<TagEditorDialog> {
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _albumController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.track.name);
    _artistController = TextEditingController(text: widget.track.artistNames.join(', '));
    _albumController = TextEditingController(text: widget.track.albumName);
    _yearController = TextEditingController(text: ''); // Year might be empty initially
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.edit_tags),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: l10n.title),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _artistController,
              decoration: InputDecoration(labelText: l10n.artist),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _albumController,
              decoration: InputDecoration(labelText: l10n.album),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () async {
            final metadata = Metadata(
              title: _titleController.text,
              artist: _artistController.text,
              album: _albumController.text,
              year: int.tryParse(_yearController.text),
            );
            
            await ref.read(localScannerProvider.notifier).updateMetadata(
              widget.track.id,
              metadata,
            );
            
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tags updated successfully')),
              );
            }
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
