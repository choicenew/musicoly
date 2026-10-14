import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_music/core/base/interfaces/player/playback_interface.dart';
import 'package:pyro_music/core/base/services/player_service.dart';
import 'package:pyro_music/core/services/service_registry.dart';

class KeyboardShortcutsHandler extends ConsumerStatefulWidget {
  final Widget child;

  const KeyboardShortcutsHandler({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<KeyboardShortcutsHandler> createState() => _KeyboardShortcutsHandlerState();
}

class _KeyboardShortcutsHandlerState extends ConsumerState<KeyboardShortcutsHandler> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'GlobalKeyboardShortcuts');

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final playerService = ServiceRegistry().getService<PlayerService>('player_service');
    if (playerService == null) return KeyEventResult.ignored;

    final key = event.logicalKey;

    // Skip if focus is on a text field
    final primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus != null && primaryFocus.context?.widget is EditableText) {
      // Still allow media keys even if text field is focused
      if (key == LogicalKeyboardKey.mediaPlayPause ||
          key == LogicalKeyboardKey.mediaTrackNext ||
          key == LogicalKeyboardKey.mediaTrackPrevious) {
        // These are usually handled by SMTC/DesktopService, but we can handle them here as fallback
      } else {
        return KeyEventResult.ignored;
      }
    }

    if (key == LogicalKeyboardKey.space) {
      if (playerService.playback.currentState == PlaybackState.playing) {
        playerService.pause();
      } else {
        final trackId = playerService.currentTrackId;
        if (trackId != null) {
          playerService.play(trackId: trackId);
        }
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowRight) {
      // Seek forward 10s or Next
      if (HardwareKeyboard.instance.isControlPressed) {
        playerService.next();
      } else {
        final currentPos = playerService.playback.position;
        playerService.seek(currentPos + const Duration(seconds: 10));
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowLeft) {
      // Seek backward 10s or Previous
      if (HardwareKeyboard.instance.isControlPressed) {
        playerService.previous();
      } else {
        final currentPos = playerService.playback.position;
        playerService.seek(currentPos - const Duration(seconds: 10));
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      // Volume up
      final currentVolume = playerService.playback.volume;
      playerService.setVolume((currentVolume + 0.1).clamp(0.0, 1.0));
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      // Volume down
      final currentVolume = playerService.playback.volume;
      playerService.setVolume((currentVolume - 0.1).clamp(0.0, 1.0));
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      canRequestFocus: true,
      descendantsAreFocusable: true,
      child: widget.child,
    );
  }
}
