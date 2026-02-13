/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLogosGen {
  const $AssetsLogosGen();

  /// File path: assets/logos/songlink-transparent.png
  AssetGenImage get songlinkTransparent =>
      const AssetGenImage('assets/logos/songlink-transparent.png');

  /// File path: assets/logos/songlink.png
  AssetGenImage get songlink =>
      const AssetGenImage('assets/logos/songlink.png');

  /// List of all assets
  List<AssetGenImage> get values => [songlinkTransparent, songlink];
}

class $AssetsTutorialGen {
  const $AssetsTutorialGen();

  /// File path: assets/tutorial/step-1.png
  AssetGenImage get step1 => const AssetGenImage('assets/tutorial/step-1.png');

  /// File path: assets/tutorial/step-2.png
  AssetGenImage get step2 => const AssetGenImage('assets/tutorial/step-2.png');

  /// File path: assets/tutorial/step-3.png
  AssetGenImage get step3 => const AssetGenImage('assets/tutorial/step-3.png');

  /// List of all assets
  List<AssetGenImage> get values => [step1, step2, step3];
}

class Assets {
  const Assets._();

  static const String license = 'LICENSE';
  static const AssetGenImage albumPlaceholder =
      AssetGenImage('assets/album-placeholder.png');
  static const AssetGenImage bengaliPatternsBg =
      AssetGenImage('assets/bengali-patterns-bg.jpg');
  static const AssetGenImage branding = AssetGenImage('assets/branding.png');
  static const AssetGenImage emptyBox = AssetGenImage('assets/empty_box.png');
  static const AssetGenImage invidious = AssetGenImage('assets/invidious.jpg');
  static const AssetGenImage jiosaavn = AssetGenImage('assets/jiosaavn.png');
  static const AssetGenImage likedTracks =
      AssetGenImage('assets/liked-tracks.jpg');
  static const $AssetsLogosGen logos = $AssetsLogosGen();
  static const AssetGenImage placeholder =
      AssetGenImage('assets/placeholder.png');
  static const AssetGenImage soundcloud =
      AssetGenImage('assets/soundcloud.jpg');
  static const AssetGenImage pyro_musicHeroBanner =
      AssetGenImage('assets/pyro_music-hero-banner.png');
  static const AssetGenImage pyro_musicLogoForeground =
      AssetGenImage('assets/pyro_music-logo-foreground.jpg');
  static const AssetGenImage pyro_musicLogoMacos =
      AssetGenImage('assets/pyro_music-logo-macos.png');
  static const AssetGenImage pyro_musicLogoBmp =
      AssetGenImage('assets/pyro_music-logo.bmp');
  static const String pyro_musicLogoIco = 'assets/pyro_music-logo.ico';
  static const AssetGenImage pyro_musicLogoPng =
      AssetGenImage('assets/pyro_music-logo.png');
  static const String pyro_musicLogoSvg = 'assets/pyro_music-logo.svg';
  static const AssetGenImage pyro_musicLogoAndroid12 =
      AssetGenImage('assets/pyro_music-logo_android12.png');
  static const AssetGenImage pyro_musicNightlyLogoForeground =
      AssetGenImage('assets/pyro_music-nightly-logo-foreground.jpg');
  static const AssetGenImage pyro_musicNightlyLogoPng =
      AssetGenImage('assets/pyro_music-nightly-logo.png');
  static const String pyro_musicNightlyLogoSvg = 'assets/pyro_music-nightly-logo.svg';
  static const AssetGenImage pyro_musicNightlyLogoAndroid12 =
      AssetGenImage('assets/pyro_music-nightly-logo_android12.png');
  static const AssetGenImage pyro_musicScreenshot =
      AssetGenImage('assets/pyro_music-screenshot.png');
  static const AssetGenImage pyro_musicTallCapsule =
      AssetGenImage('assets/pyro_music-tall-capsule.png');
  static const AssetGenImage pyro_musicWideCapsuleLarge =
      AssetGenImage('assets/pyro_music-wide-capsule-large.png');
  static const AssetGenImage pyro_musicWideCapsuleSmall =
      AssetGenImage('assets/pyro_music-wide-capsule-small.png');
  static const AssetGenImage pyro_musicBanner =
      AssetGenImage('assets/pyro_music_banner.png');
  static const AssetGenImage success = AssetGenImage('assets/success.png');
  static const $AssetsTutorialGen tutorial = $AssetsTutorialGen();
  static const AssetGenImage userPlaceholder =
      AssetGenImage('assets/user-placeholder.png');

  /// List of all assets
  static List<dynamic> get values => [
        license,
        albumPlaceholder,
        bengaliPatternsBg,
        branding,
        emptyBox,
        invidious,
        jiosaavn,
        likedTracks,
        placeholder,
        soundcloud,
        pyro_musicHeroBanner,
        pyro_musicLogoForeground,
        pyro_musicLogoMacos,
        pyro_musicLogoBmp,
        pyro_musicLogoIco,
        pyro_musicLogoPng,
        pyro_musicLogoSvg,
        pyro_musicLogoAndroid12,
        pyro_musicNightlyLogoForeground,
        pyro_musicNightlyLogoPng,
        pyro_musicNightlyLogoSvg,
        pyro_musicNightlyLogoAndroid12,
        pyro_musicScreenshot,
        pyro_musicTallCapsule,
        pyro_musicWideCapsuleLarge,
        pyro_musicWideCapsuleSmall,
        pyro_musicBanner,
        success,
        userPlaceholder
      ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
