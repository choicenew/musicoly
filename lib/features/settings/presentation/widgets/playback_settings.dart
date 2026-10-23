import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:pyro_music/features/player/services/audio_service.dart';
import 'package:pyro_music/features/settings/providers/user_preferences_provider.dart';
import 'package:pyro_music/features/player/providers/sleep_timer_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class PlaybackSettings extends ConsumerStatefulWidget {
  const PlaybackSettings({super.key});

  @override
  ConsumerState<PlaybackSettings> createState() => _PlaybackSettingsState();
}

class _PlaybackSettingsState extends ConsumerState<PlaybackSettings> {
  void _showSleepTimerDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.sleep_timer),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.off),
              onTap: () {
                ref.read(sleepTimerProvider.notifier).stop();
                Navigator.pop(context);
              },
            ),
            ...[15, 30, 45, 60, 90].map((mins) => ListTile(
              title: Text(l10n.minutes(mins)),
              onTap: () {
                ref.read(sleepTimerProvider.notifier).start(Duration(minutes: mins));
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preferencesAsync = ref.watch(userPreferencesProvider);
    final audioService = provider.Provider.of<AudioService>(context, listen: false);
    final remainingTime = ref.watch(sleepTimerProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: preferencesAsync.when(
          data: (preferences) => Column(
            children: [
              ListTile(
                title: Text(l10n.audio_quality),
                subtitle: Text(l10n.select_audio_quality),
                trailing: DropdownButton<String>(
                  value: audioService.currentQuality,
                  items: [
                    DropdownMenuItem(value: 'low', child: Text(l10n.low_quality)),
                    DropdownMenuItem(value: 'medium', child: Text(l10n.medium_quality)),
                    DropdownMenuItem(value: 'high', child: Text(l10n.high_quality)),
                  ],
                  onChanged: (value) {
                    // TODO: Implement quality change in AudioService if available
                  },
                ),
              ),
              ListTile(
                title: Text(l10n.crossfade),
                subtitle: Text(l10n.crossfade_description), 
                trailing: DropdownButton<int>(
                  value: preferences.crossfadeDuration,
                  items: [
                    DropdownMenuItem(value: 0, child: Text(l10n.off)),
                    DropdownMenuItem(value: 1, child: Text(l10n.seconds(1))),
                    DropdownMenuItem(value: 2, child: Text(l10n.seconds(2))),
                    DropdownMenuItem(value: 3, child: Text(l10n.seconds(3))),
                  ],
                  onChanged: (value) async {
                    if (value != null) {
                        final duration = Duration(seconds: value);
                        await ref.read(userPreferencesProvider.notifier).setCrossfadeDuration(value);
                        await audioService.applyCrossfadeEffect(duration);
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(l10n.sleep_timer),
                subtitle: Text(remainingTime != null 
                  ? '${l10n.sleep_timer_description} (${remainingTime.inMinutes}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')})'
                  : l10n.sleep_timer_description),
                trailing: const Icon(Icons.timer),
                onTap: () => _showSleepTimerDialog(context, l10n),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
