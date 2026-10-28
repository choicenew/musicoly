import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pyro_music/core/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_taskbar/windows_taskbar.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:smtc_windows/smtc_windows.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:pyro_music/core/services/service_registry.dart';
import 'package:pyro_music/core/models/playback_state.dart';
import 'package:pyro_music/features/player/services/player_service.dart';

class DesktopService extends BaseService with TrayListener, WindowListener {
  @override
  String get serviceId => 'desktop_service';

  @override
  String get serviceName => 'Desktop Integration Service';

  @override
  String get serviceVersion => '1.0.0';

  @override
  String? get platform => 'desktop';

  bool _isInitialized = false;
  SMTCWindows? _smtc;

  @override
  Future<void> initialize() async {
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) return;
    if (_isInitialized) return;

    // Initialize Window Manager
    await windowManager.ensureInitialized();
    windowManager.addListener(this);
    await windowManager.setPreventClose(true); // Handle close manually

    // Initialize Tray Manager
    await trayManager.setIcon(
      Platform.isWindows ? 'assets/pyro_music-logo.ico' : 'assets/pyro_music-logo.png',
    );
    trayManager.addListener(this);

    // Initialize Local Notifier
    await localNotifier.setup(
      appName: 'Pyro Music',
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );

    // Initialize SMTC (Windows only)
    if (Platform.isWindows) {
      _setupSMTC();
    }

    _isInitialized = true;
    _updateTrayMenu();
  }

  @override
  void onWindowClose() async {
    final prefs = await SharedPreferences.getInstance();
    final minimizeToTray = prefs.getBool('minimizeToTray') ?? true;

    if (minimizeToTray) {
      await windowManager.hide();
    } else {
      await windowManager.destroy();
    }
  }

  Future<void> setAutoStart(bool enabled) async {
    if (!Platform.isWindows) return;

    try {
      const keyPath = r'Software\Microsoft\Windows\CurrentVersion\Run';
      final key = Registry.currentUser.createKey(keyPath);
      
      if (enabled) {
        final executablePath = Platform.resolvedExecutable;
        key.createValue(RegistryValue('PyroMusic', RegistryValueType.string, executablePath));
      } else {
        try {
          key.deleteValue('PyroMusic');
        } catch (_) {}
      }
      key.close();
    } catch (e) {
      debugPrint('Error setting auto-start: $e');
    }
  }

  void _setupSMTC() async {
    final prefs = await SharedPreferences.getInstance();
    final mediaKeyControl = prefs.getBool('mediaKeyControl') ?? true;

    if (Platform.isWindows) {
      _smtc = SMTCWindows(
        config: SMTCConfig(
          playEnabled: mediaKeyControl,
          pauseEnabled: mediaKeyControl,
          nextEnabled: mediaKeyControl,
          prevEnabled: mediaKeyControl,
          stopEnabled: mediaKeyControl,
          fastForwardEnabled: false,
          rewindEnabled: false,
        ),
      );
    }
    
    if (_smtc == null) return;
    
    final playerService = ServiceRegistry().getService<PlayerService>('player_service');

    _smtc!.buttonPressStream.listen((button) {
      switch (button) {
        case PressedButton.play:
          final trackId = playerService?.currentTrackId;
          if (trackId != null) {
            playerService?.play(trackId: trackId);
          }
          break;
        case PressedButton.pause:
          playerService?.pause();
          break;
        case PressedButton.next:
          playerService?.next();
          break;
        case PressedButton.previous:
          playerService?.previous();
          break;
        default:
          break;
      }
    });
  }

  void updateMetadata(String title, String artist, {String? album, String? imageUrl}) {
    if (Platform.isWindows && _smtc != null) {
      _smtc!.updateMetadata(
        MusicMetadata(
          title: title,
          artist: artist,
          album: album,
          thumbnail: imageUrl,
        ),
      );
    }
  }

  void updatePlaybackState(bool isPlaying) {
    if (Platform.isWindows && _smtc != null) {
      _smtc!.setPlaybackStatus(
        isPlaying ? PlaybackStatus.playing : PlaybackStatus.paused,
      );
    }
    _updateTrayMenu();
  }

  Future<void> _updateTrayMenu() async {
    final playerService = ServiceRegistry().getService<PlayerService>('player_service');
    final isPlaying = playerService?.playback.currentState == PlaybackState.playing;
    final track = await playerService?.getCurrentTrack();
    
    // Use system context for l10n if possible, or fallback to English
    // Note: In a service, we don't have a BuildContext. We can use the current locale or just defaults.
    // For now, let's keep it simple or use a static translation map if needed.

    List<MenuItem> items = [
      if (track != null) ...[
        MenuItem(
          key: 'current_track',
          label: '${track.name} - ${track.artistNames.join(", ")}',
          disabled: true,
        ),
        MenuItem.separator(),
      ],
      MenuItem(
        key: 'show_window',
        label: 'Show Window',
      ),
      MenuItem.separator(),
      MenuItem(
        key: 'play_pause',
        label: isPlaying ? 'Pause' : 'Play',
      ),
      MenuItem(
        key: 'next',
        label: 'Next',
      ),
      MenuItem(
        key: 'previous',
        label: 'Previous',
      ),
      MenuItem.separator(),
      MenuItem(
        key: 'exit',
        label: 'Exit',
      ),
    ];
    await trayManager.setContextMenu(Menu(items: items));
  }

  // --- TrayListener ---
  @override
  void onTrayIconMouseDown() {
    windowManager.show();
    windowManager.focus();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    final playerService = ServiceRegistry().getService<PlayerService>('player_service');
    
    switch (menuItem.key) {
      case 'show_window':
        windowManager.show();
        windowManager.focus();
        break;
      case 'play_pause':
        if (playerService != null) {
          if (playerService.playback.currentState == PlaybackState.playing) {
            await playerService.pause();
          } else {
            final trackId = playerService.currentTrackId;
            if (trackId != null) {
              await playerService.play(trackId: trackId);
            }
          }
          _updateTrayMenu();
        }
        break;
      case 'next':
        await playerService?.next();
        break;
      case 'previous':
        await playerService?.previous();
        break;
      case 'exit':
        await windowManager.destroy();
        break;
    }
  }

  // --- WindowListener ---
  
  // --- Taskbar & Notifications ---
  
  void updateTaskbarProgress(double progress) {
    if (Platform.isWindows) {
      WindowsTaskbar.setProgress(
        (progress * 100).toInt(),
        100,
      );
    }
  }

  void setTaskbarStatus(bool isPlaying) {
    if (Platform.isWindows) {
      WindowsTaskbar.setProgressMode(
        isPlaying ? TaskbarProgressMode.normal : TaskbarProgressMode.paused,
      );
    }
  }

  Future<void> showNotification(String title, String subtitle, {String? imagePath}) async {
    final prefs = await SharedPreferences.getInstance();
    final systemNotifications = prefs.getBool('systemNotifications') ?? true;
    
    if (!systemNotifications) return;

    LocalNotification notification = LocalNotification(
      title: title,
      body: subtitle,
    );
    notification.onShow = () {
      debugPrint('Notification shown');
    };
    notification.onClose = (closeReason) {
      debugPrint('Notification closed: $closeReason');
    };
    notification.onClick = () {
      windowManager.show();
      windowManager.focus();
    };
    await notification.show();
  }

  @override
  Future<void> dispose() async {
    windowManager.removeListener(this);
    trayManager.removeListener(this);
    super.dispose();
  }
}
