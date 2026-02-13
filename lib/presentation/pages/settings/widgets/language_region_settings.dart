import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pyro_music/core/providers/user_preferences_provider.dart';
import 'package:pyro_music/features/language/provider/language_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';

class LanguageRegionSettings extends ConsumerStatefulWidget {
  const LanguageRegionSettings({super.key});

  @override
  ConsumerState<LanguageRegionSettings> createState() => _LanguageRegionSettingsState();
}

class _LanguageRegionSettingsState extends ConsumerState<LanguageRegionSettings> {
  // 初始化时区列表避免空值
  List<String> _timeZones = [];
  String _initialTimeZone = 'UTC';

  @override
  void initState() {
    super.initState();
    // 异步加载时区数据
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final zones = await FlutterTimezone.getAvailableTimezones();
      if (mounted) {
        setState(() {
          _timeZones = zones;
          _initialTimeZone = zones.firstWhere(
            (zone) => zone == 'Asia/Shanghai',
            orElse: () => 'UTC'
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final preferencesAsync = ref.watch(userPreferencesProvider);
    final currentLocaleAsync = ref.watch(localeProvider);
    // 添加空安全检查
    final l10n = AppLocalizations.of(context);

    // 处理加载状态
    if (_timeZones.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: preferencesAsync.when(
          data: (preferences) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 语言选择
              ListTile(
                title: Text(l10n!.language),
                trailing: DropdownButton<Locale>(
                  // 使用有效默认值
                  value: currentLocaleAsync.asData?.value,
                  items: [
                    ...AppLocalizations.supportedLocales.map((locale) {
                      final displayName = _getLanguageName(locale, l10n);
                      return DropdownMenuItem(
                        value: locale,
                        child: Text(displayName),
                      );
                    }),
                  ],
                  onChanged: (locale) {
                     if (locale != null) {
                       ref.read(localeProvider.notifier).updateLocale(locale);
                     }
                  },
                ),
              ),

              // 时区选择
              ListTile(
                title: Text(l10n.timeZone),
                trailing: DropdownButton<String>(
                  value: preferences.timeZone ?? _initialTimeZone,
                  items: _timeZones.map((zone) {
                    return DropdownMenuItem(
                      value: zone,
                      child: Text(zone),
                    );
                  }).toList(),
                  onChanged: (zone) {
                    if (zone != null) {
                      ref.read(userPreferencesProvider.notifier).setTimeZone(zone);
                    }
                  },
                ),
              ),

              // 时间格式
              SwitchListTile(
                title: Text(l10n.timeFormat),
                subtitle: Text(l10n.use24HourFormat),
                value: preferences.use24HourFormat,
                onChanged: (value) {
                  ref.read(userPreferencesProvider.notifier)
                    .setUse24HourFormat(value);
                },
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  String _getLanguageName(Locale locale, AppLocalizations l10n) {
    switch (locale.languageCode) {
      case 'zh':
        return l10n.chinese;
      case 'en':
        return l10n.english;
      case 'ja':
        return l10n.japanese;
      default:
        return locale.toString();
    }
  }
}
