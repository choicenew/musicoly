import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:pyro_music/features/plugin/aggregator/media_aggregator.dart';
import 'package:pyro_music/features/plugin/runtime/plugin_runtime_container.dart';

/// 首页 Feed 聚合驱动服务
class HomeService extends BaseService {
  final PluginRuntimeContainer _pluginContainer = PluginRuntimeContainer();

  @override
  String get serviceId => 'home_service';

  @override
  String get serviceName => 'Home Feed Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => null;

  /// 从所有已加载插件获取并聚合动态推荐 Section
  Future<List<HomeSectionModel>> fetchHomeFeed() async {
    final activePlugins = _pluginContainer.getActivePlugins();
    final List<List<HomeSectionModel>> allPluginSections = [];

    for (final plugin in activePlugins) {
      try {
        final sections = await plugin.fetchHomeSections();
        allPluginSections.add(sections);
      } catch (e) {
        // 单个插件出现异常不影响全局，继续加载其他插件
      }
    }

    // 调用多源去重与无感广告自然渗透引擎
    return MediaAggregator.aggregateHomeSections(allPluginSections);
  }
}
