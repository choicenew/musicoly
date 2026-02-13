// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

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

  static const AssetGenImage albumPlaceholder = AssetGenImage(
    'assets/album-placeholder.png',
  );
  static const AssetGenImage bengaliPatternsBg = AssetGenImage(
    'assets/bengali-patterns-bg.jpg',
  );
  static const AssetGenImage branding = AssetGenImage('assets/branding.png');
  static const AssetGenImage emptyBox = AssetGenImage('assets/empty_box.png');
  static const AssetGenImage invidious = AssetGenImage('assets/invidious.jpg');
  static const AssetGenImage jiosaavn = AssetGenImage('assets/jiosaavn.png');
  static const AssetGenImage likedTracks = AssetGenImage(
    'assets/liked-tracks.jpg',
  );
  static const $AssetsLogosGen logos = $AssetsLogosGen();
  static const AssetGenImage placeholder = AssetGenImage(
    'assets/placeholder.png',
  );
  static const AssetGenImage pyroMusicHeroBanner = AssetGenImage(
    'assets/pyro_music-hero-banner.png',
  );
  static const AssetGenImage pyroMusicLogoForeground = AssetGenImage(
    'assets/pyro_music-logo-foreground.jpg',
  );
  static const AssetGenImage pyroMusicLogoMacos = AssetGenImage(
    'assets/pyro_music-logo-macos.png',
  );
  static const AssetGenImage pyroMusicLogoBmp = AssetGenImage(
    'assets/pyro_music-logo.bmp',
  );
  static const String pyroMusicLogoIco = 'assets/pyro_music-logo.ico';
  static const AssetGenImage pyroMusicLogoPng = AssetGenImage(
    'assets/pyro_music-logo.png',
  );
  static const String pyroMusicLogoSvg = 'assets/pyro_music-logo.svg';
  static const AssetGenImage pyroMusicLogoAndroid12 = AssetGenImage(
    'assets/pyro_music-logo_android12.png',
  );
  static const AssetGenImage pyroMusicNightlyLogoForeground = AssetGenImage(
    'assets/pyro_music-nightly-logo-foreground.jpg',
  );
  static const AssetGenImage pyroMusicNightlyLogoPng = AssetGenImage(
    'assets/pyro_music-nightly-logo.png',
  );
  static const String pyroMusicNightlyLogoSvg =
      'assets/pyro_music-nightly-logo.svg';
  static const AssetGenImage pyroMusicNightlyLogoAndroid12 = AssetGenImage(
    'assets/pyro_music-nightly-logo_android12.png',
  );
  static const AssetGenImage pyroMusicScreenshot = AssetGenImage(
    'assets/pyro_music-screenshot.png',
  );
  static const AssetGenImage pyroMusicTallCapsule = AssetGenImage(
    'assets/pyro_music-tall-capsule.png',
  );
  static const AssetGenImage pyroMusicWideCapsuleLarge = AssetGenImage(
    'assets/pyro_music-wide-capsule-large.png',
  );
  static const AssetGenImage pyroMusicWideCapsuleSmall = AssetGenImage(
    'assets/pyro_music-wide-capsule-small.png',
  );
  static const AssetGenImage pyroMusicBanner = AssetGenImage(
    'assets/pyro_music_banner.png',
  );
  static const AssetGenImage soundcloud = AssetGenImage(
    'assets/soundcloud.jpg',
  );
  static const AssetGenImage success = AssetGenImage('assets/success.png');
  static const $AssetsTutorialGen tutorial = $AssetsTutorialGen();
  static const AssetGenImage userPlaceholder = AssetGenImage(
    'assets/user-placeholder.png',
  );

  /// List of all assets
  static List<dynamic> get values => [
    albumPlaceholder,
    bengaliPatternsBg,
    branding,
    emptyBox,
    invidious,
    jiosaavn,
    likedTracks,
    placeholder,
    pyroMusicHeroBanner,
    pyroMusicLogoForeground,
    pyroMusicLogoMacos,
    pyroMusicLogoBmp,
    pyroMusicLogoIco,
    pyroMusicLogoPng,
    pyroMusicLogoSvg,
    pyroMusicLogoAndroid12,
    pyroMusicNightlyLogoForeground,
    pyroMusicNightlyLogoPng,
    pyroMusicNightlyLogoSvg,
    pyroMusicNightlyLogoAndroid12,
    pyroMusicScreenshot,
    pyroMusicTallCapsule,
    pyroMusicWideCapsuleLarge,
    pyroMusicWideCapsuleSmall,
    pyroMusicBanner,
    soundcloud,
    success,
    userPlaceholder,
  ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
