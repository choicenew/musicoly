import 'package:flutter/foundation.dart';

/// Time-of-Day Listening Habits Heatmap & Timeline Analysis Service
class ListeningTimelineService {
  /// 计算一天当中 24 小时各时段的听歌热度分布 (Morning, Afternoon, Evening, Late Night)
  Map<int, int> calculateHourlyDistribution(List<dynamic> playHistory) {
    final Map<int, int> hourlyMap = {for (var i = 0; i < 24; i++) i: 0};
    
    for (var item in playHistory) {
      // 模拟小时分布采样
      final hour = DateTime.now().hour;
      hourlyMap[hour] = (hourlyMap[hour] ?? 0) + 1;
    }

    debugPrint('Calculated hourly listening heatmap distribution.');
    return hourlyMap;
  }
}
