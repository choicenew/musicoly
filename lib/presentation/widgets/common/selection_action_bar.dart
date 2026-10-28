import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/features/local_music/providers/multi_select_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class SelectionActionBar extends ConsumerWidget {
  final VoidCallback? onPlayNext;
  final VoidCallback? onAddToPlaylist;
  final VoidCallback? onDelete;
  final List<String> allIds;

  const SelectionActionBar({
    super.key,
    this.onPlayNext,
    this.onAddToPlaylist,
    this.onDelete,
    required this.allIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIds = ref.watch(multiSelectProvider);
    if (selectedIds.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(0x33),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Text(
              l10n.selected_count(selectedIds.length),
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            if (onPlayNext != null)
              IconButton(
                icon: const Icon(Icons.playlist_play),
                tooltip: l10n.play_next,
                onPressed: onPlayNext,
              ),
            if (onAddToPlaylist != null)
              IconButton(
                icon: const Icon(Icons.add_to_photos),
                tooltip: l10n.add_to_playlist,
                onPressed: onAddToPlaylist,
              ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: l10n.delete,
                onPressed: onDelete,
              ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => ref.read(multiSelectProvider.notifier).clear(),
              child: Text(l10n.cancel),
            ),
          ],
        ),
      ),
    );
  }
}
