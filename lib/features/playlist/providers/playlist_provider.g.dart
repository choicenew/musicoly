// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the playlist service implementation

@ProviderFor(playlistService)
final playlistServiceProvider = PlaylistServiceProvider._();

/// Provider for the playlist service implementation

final class PlaylistServiceProvider
    extends
        $FunctionalProvider<
          PlaylistServiceImpl,
          PlaylistServiceImpl,
          PlaylistServiceImpl
        >
    with $Provider<PlaylistServiceImpl> {
  /// Provider for the playlist service implementation
  PlaylistServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playlistServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playlistServiceHash();

  @$internal
  @override
  $ProviderElement<PlaylistServiceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlaylistServiceImpl create(Ref ref) {
    return playlistService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaylistServiceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaylistServiceImpl>(value),
    );
  }
}

String _$playlistServiceHash() => r'6d117cff4c75f1fcdf1157be1a837a083f8b8dd8';

/// Notifier for playlist state

@ProviderFor(PlaylistNotifier)
final playlistProvider = PlaylistNotifierProvider._();

/// Notifier for playlist state
final class PlaylistNotifierProvider
    extends $NotifierProvider<PlaylistNotifier, PlaylistStateData> {
  /// Notifier for playlist state
  PlaylistNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playlistProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playlistNotifierHash();

  @$internal
  @override
  PlaylistNotifier create() => PlaylistNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaylistStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaylistStateData>(value),
    );
  }
}

String _$playlistNotifierHash() => r'61214ae47edb6abc0a4591e9e355c716ee16aa71';

/// Notifier for playlist state

abstract class _$PlaylistNotifier extends $Notifier<PlaylistStateData> {
  PlaylistStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlaylistStateData, PlaylistStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaylistStateData, PlaylistStateData>,
              PlaylistStateData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
