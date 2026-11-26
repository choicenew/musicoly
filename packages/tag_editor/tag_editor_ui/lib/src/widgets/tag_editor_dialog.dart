import 'package:flutter/material.dart';

class TagEditorDialog extends StatelessWidget {
  const TagEditorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit ID3 Audio Tags'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(decoration: InputDecoration(labelText: 'Title')),
          TextField(decoration: InputDecoration(labelText: 'Artist')),
          TextField(decoration: InputDecoration(labelText: 'Album')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Save')),
      ],
    );
  }
}
