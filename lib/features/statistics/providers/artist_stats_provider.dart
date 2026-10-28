import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_music/core/models/artist_model.dart';
import 'package:pyro_music/core/models/track_model.dart';
import 'package:pyro_music/core/models/stats_model.dart';
import 'package:pyro_music/features/statistics/services/artist_stats_service_impl.dart';
import 'package:pyro_music/features/player/providers/player_state_provider.dart';

part 'artist_stats_provider.freezed.dart';
part 'artist_stats_provider.g.dart';

@freezed
abstract class ArtistStatsState with _$ArtistStatsState {
  const factory ArtistStatsState({
    @Default([]) List<ArtistStatsModel> currentArtistStats,
    @Default([]) List<ArtistStatsModel> topArtists,
  }) = _ArtistStatsState;
}

/// 艺术家统计提供者实现
@Riverpod(keepAlive: true)
class ArtistStatsNotifier extends _$ArtistStatsNotifier {
  late final ArtistStatsServiceImpl _serviceImpl;

  @override
  ArtistStatsState build() {
    _serviceImpl = ArtistStatsServiceImpl();
    
    _listenToPlayerState();
    loadStats();
    
    return const ArtistStatsState();
  }

  /// 加载统计数据
  Future<void> loadStats() async {
    try {
      final top = await _serviceImpl.getTopArtists();
      state = state.copyWith(topArtists: top);
    } catch (e) {
      // Handle error
    }
  }
  
  void _listenToPlayerState() {
    // Watch current track
    ref.listen(playerStateProvider.select((s) => s.currentTrack), (previous, next) {
      _onTrackChanged(next);
    });
  }

  /// 当前曲目变化处理
  void _onTrackChanged(TrackModel? track) {
    if (track == null || track.artistIds.isEmpty) {
      state = state.copyWith(currentArtistStats: []);
      return;
    }

    // 加载当前曲目艺术家的统计信息
    _loadCurrentArtistStats(track.artistIds, track.artistNames);
  }

  /// 加载当前艺术家统计
  Future<void> _loadCurrentArtistStats(
      List<String> artistIds, List<String> artistNames) async {
    try {
      final statsList = <ArtistStatsModel>[];

      for (int i = 0; i < artistIds.length; i++) {
        final artist = ArtistModel(
          id: artistIds[i],
          platform: 'local',
          name: i < artistNames.length ? artistNames[i] : 'Unknown Artist',
        );

        final stats = await _serviceImpl.getArtistStats(artist);
        if (stats != null) {
          statsList.add(stats);
        }
      }

      state = state.copyWith(currentArtistStats: statsList);
    } catch (e) {
      // Handle error
    }
  }

  Future<ArtistStatsModel?> getArtistStats(ArtistModel artist) async {
    return await _serviceImpl.getArtistStats(artist);
  }
}
