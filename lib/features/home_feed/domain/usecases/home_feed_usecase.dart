import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/features/home_feed/domain/repositories/media_repository.dart';

/// UseCase to fetch and aggregate Home Feed from plugins
class HomeFeedUseCase {
  final MediaRepository repository;

  HomeFeedUseCase(this.repository);

  Future<List<HomeSectionModel>> execute() async {
    return await repository.getAggregatedHomeFeed();
  }
}
