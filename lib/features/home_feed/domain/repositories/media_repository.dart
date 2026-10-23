import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/features/plugin/aggregator/media_aggregator.dart';
import 'package:pyro_music/features/plugin/runtime/plugin_runtime_container.dart';

/// Abstract Repository for Media Operations across Dynamic Plugins
abstract class MediaRepository {
  Future<List<HomeSectionModel>> getAggregatedHomeFeed();
}

/// Implementation of MediaRepository querying active plugins from host container
class MediaRepositoryImpl implements MediaRepository {
  final PluginRuntimeContainer runtimeContainer;

  MediaRepositoryImpl({required this.runtimeContainer});

  @override
  Future<List<HomeSectionModel>> getAggregatedHomeFeed() async {
    final activePlugins = runtimeContainer.getActivePlugins();
    final List<List<HomeSectionModel>> results = [];

    for (final plugin in activePlugins) {
      try {
        final sections = await plugin.fetchHomeSections();
        results.add(sections);
      } catch (_) {
        // Individual plugin failure isolation
      }
    }

    return MediaAggregator.aggregateHomeSections(results);
  }
}
