import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/features/plugin/runtime/plugin_runtime_container.dart';
import 'package:pyro_music/features/home_feed/domain/repositories/media_repository.dart';
import 'package:pyro_music/features/home_feed/domain/usecases/home_feed_usecase.dart';

/// Home Feed UI state representations
sealed class HomeFeedState {
  const HomeFeedState();
}

class HomeFeedLoading extends HomeFeedState {
  const HomeFeedLoading();
}

class HomeFeedSuccess extends HomeFeedState {
  final List<HomeSectionModel> sections;
  const HomeFeedSuccess(this.sections);
}

class HomeFeedEmpty extends HomeFeedState {
  const HomeFeedEmpty();
}

class HomeFeedError extends HomeFeedState {
  final String message;
  const HomeFeedError(this.message);
}

/// Provider for MediaRepository
final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  return MediaRepositoryImpl(runtimeContainer: PluginRuntimeContainer());
});

/// Provider for HomeFeedUseCase
final homeFeedUseCaseProvider = Provider<HomeFeedUseCase>((ref) {
  return HomeFeedUseCase(ref.watch(mediaRepositoryProvider));
});

/// Riverpod Notifier Provider for Home Feed State
final homeFeedNotifierProvider =
    NotifierProvider<HomeFeedNotifier, HomeFeedState>(() {
  return HomeFeedNotifier();
});

class HomeFeedNotifier extends Notifier<HomeFeedState> {
  late final HomeFeedUseCase _useCase;

  @override
  HomeFeedState build() {
    _useCase = ref.watch(homeFeedUseCaseProvider);
    loadHomeFeed();
    return const HomeFeedLoading();
  }

  Future<void> loadHomeFeed() async {
    state = const HomeFeedLoading();
    try {
      final sections = await _useCase.execute();
      if (sections.isEmpty) {
        state = const HomeFeedEmpty();
      } else {
        state = HomeFeedSuccess(sections);
      }
    } catch (e) {
      state = HomeFeedError(e.toString());
    }
  }
}
