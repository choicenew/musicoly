import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyro_music/core/models/lyric_data_model.dart';

/// 实时歌词卡拉OK打轴与时间戳编辑器 (Karaoke Lyric Time-Tagging Editor)
class LyricTimeTagEditorModal extends StatefulWidget {
  final List<String> rawLines;
  final Function(String lrcContent) onSaved;

  const LyricTimeTagEditorModal({
    super.key,
    required this.rawLines,
    required this.onSaved,
  });

  @override
  State<LyricTimeTagEditorModal> createState() => _LyricTimeTagEditorModalState();
}

class _LyricTimeTagEditorModalState extends State<LyricTimeTagEditorModal> {
  int _currentIndex = 0;
  final List<ParsedLyricLine> _stampedLines = [];
  Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    for (var text in widget.rawLines) {
      _stampedLines.add(ParsedLyricLine(text: text));
    }
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _stampCurrentLine() {
    if (_currentIndex < _stampedLines.length) {
      final elapsed = _stopwatch.elapsed;
      setState(() {
        _stampedLines[_currentIndex].timestamp = elapsed;
        if (_currentIndex < _stampedLines.length - 1) {
          _currentIndex++;
        }
      });
    }
  }

  String _formatDuration(Duration d) {
    final mins = d.inMinutes.toString().padLeft(2, '0');
    final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
    final ms = (d.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return '[$mins:$secs.$ms]';
  }

  String _generateLrc() {
    final buffer = StringBuffer();
    for (var line in _stampedLines) {
      final ts = line.timestamp != null ? _formatDuration(line.timestamp!) : '[00:00.00]';
      buffer.writeln('$ts${line.text}');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 实时歌词卡拉OK打轴编辑器'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final lrc = _generateLrc();
              widget.onSaved(lrc);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: theme.colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '当前进度: ${_formatDuration(_stopwatch.elapsed)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _stampCurrentLine,
                  icon: const Icon(Icons.bolt),
                  label: const Text('敲击打轴 (Stamp)'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _stampedLines.length,
              itemBuilder: (context, index) {
                final line = _stampedLines[index];
                final isCurrent = index == _currentIndex;

                return ListTile(
                  tileColor: isCurrent ? theme.colorScheme.primary.withValues(alpha: 0.15) : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  leading: Text(
                    line.timestamp != null ? _formatDuration(line.timestamp!) : '--:--',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: line.timestamp != null ? theme.colorScheme.primary : Colors.grey,
                    ),
                  ),
                  title: Text(
                    line.text,
                    style: TextStyle(
                      fontSize: isCurrent ? 18 : 15,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ParsedLyricLine {
  final String text;
  Duration? timestamp;

  ParsedLyricLine({required this.text, this.timestamp});
}
