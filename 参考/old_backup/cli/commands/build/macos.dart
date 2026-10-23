import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';

import 'common.dart';

class MacosBuildCommand extends Command with BuildCommandCommonSteps {
  @override
  String get description => "Macos Build command";

  @override
  String get name => "macos";

  @override
  FutureOr? run() async {
    await bootstrap();

    await shell.run(
      """
      flutter build macos
      appdmg appdmg.json ${join(cwd.path, "build", "Pyro Music-macos-universal.dmg")}
      flutter_distributor package --platform=macos --targets pkg --skip-clean
      """,
    );

    final ogPkg = File(
      join(
        cwd.path,
        "dist",
        pubspec.version.toString(),
        "pyro_music-${pubspec.version}-macos.pkg",
      ),
    );

    await ogPkg.copy(
      join(cwd.path, "build", "Pyro Music-macos-universal.pkg"),
    );
    await ogPkg.delete();
  }
}
