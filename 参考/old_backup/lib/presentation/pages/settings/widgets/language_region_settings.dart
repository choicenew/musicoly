import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:provider/provider.dart';
import 'package:pyro_music/core/providers/user_preferences_provider.dart';
// 添加本地化文件导入
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageRegionSettings extends StatefulWidget {
  const LanguageRegionSettings({super.key});

  @override
  State<LanguageRegionSettings> createState() => _LanguageRegionSettingsState();
}




class _LanguageRegionSettingsState extends State<LanguageRegionSettings> {
  // 初始化时区列表避免空值
  List<String> _timeZones = [];
  String _initialTimeZone = 'UTC';

  @override
  void initState() {
    super.initState();
    // 异步加载时区数据
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final zones = await FlutterTimezone.getAvailableTimezones();
      setState(() {
        _timeZones = zones;
        _initialTimeZone = zones.firstWhere(
          (zone) => zone == 'Asia/Shanghai',
          orElse: () => 'UTC'
        );
      });
      context.read<UserPreferencesProvider>().initializeTimeZone();
    });
  }

  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<UserPreferencesProvider>();
    // 添加空安全检查
    final l10n = AppLocalizations.of(context);

    // 处理加载状态
    if (_timeZones.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 语言选择
            ListTile(
              title: Text(l10n!.language),
              trailing: DropdownButton<Locale>(
                // 使用有效默认值
                value: preferences.locale ?? const Locale('system'),
                items: [
                  const DropdownMenuItem(
                    value: Locale('system'),
                    child: Text('跟随系统'),
                  ),
                  ...AppLocalizations.supportedLocales.map((locale) {
                    final displayName = _getLanguageName(locale, l10n);
                    return DropdownMenuItem(
                      value: locale,
                      child: Text(displayName),
                    );
                  }),
                ],
                onChanged: (locale) {
                  preferences.setLocale(locale!);
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
                  context.read<UserPreferencesProvider>().setTimeZone(zone!);
                },
              ),
            ),

            // 时间格式
            SwitchListTile(
              title: Text(l10n.timeFormat),
              subtitle: Text(l10n.use24HourFormat),
              value: preferences.use24HourFormat,
              onChanged: (value) {
                context.read<UserPreferencesProvider>()
                  .setUse24HourFormat(value);
              },
            ),
          ],
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
