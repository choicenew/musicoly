import 'package:pyro_music/core/models/ad_media_model.dart';
import 'package:pyro_music/core/models/home_section_model.dart';
import 'package:pyro_music/core/models/media_model.dart';
import 'package:pyro_music/features/plugin/plugin_source_contract.dart';

/// Dynamic Sponsor Ad Plugin providing native square, circle, and tile Ad items
class AdSectionPlugin implements PluginSourceContract {
  @override
  String get pluginId => 'org.pyromusic.ads';

  @override
  String get pluginName => 'Sponsor Ads';

  @override
  String get version => '1.0.0';

  @override
  String? get description => 'Dynamic native sponsor advertisement plugin';

  @override
  Future<List<HomeSectionModel>> fetchHomeSections() async {
    const nativeSquareAd = AdMediaModel(
      id: 'ad_square_1',
      name: 'Pyro Hi-Res DAC Amp',
      description: 'Lossless 32-bit audio adapter',
      sponsorTag: 'Sponsor',
      targetUrl: 'https://pyromusic.org/gear',
      cardShape: AdCardShape.square,
    );

    const nativeCircleAd = AdMediaModel(
      id: 'ad_circle_1',
      name: 'Acoustics Lab',
      description: 'Audio Brand',
      sponsorTag: 'Featured Brand',
      targetUrl: 'https://pyromusic.org/brand',
      cardShape: AdCardShape.circle,
    );

    const nativeTileAd = AdMediaModel(
      id: 'ad_tile_1',
      name: 'Studio Master Headphones Edition',
      description: 'Sponsored Audio Series',
      sponsorTag: 'Sponsored Track',
      targetUrl: 'https://pyromusic.org/audio',
      cardShape: AdCardShape.tile,
    );

    return [
      const HomeSectionModel(
        id: 'ad_native_stream',
        title: 'Featured Sponsor',
        subtitle: 'Handpicked audio gear & brands',
        type: HomeSectionType.carousel,
        items: [nativeSquareAd, nativeCircleAd, nativeTileAd],
        isAdSection: true,
      ),
    ];
  }

  @override
  Future<List<MediaModel>> search(String query, {List<String>? types}) async {
    return [];
  }

  @override
  Future<AudioStreamInfo> fetchAudioStream(String trackId) async {
    throw UnimplementedError('Ad plugin does not provide audio streams');
  }
}
