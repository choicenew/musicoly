import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';

import '../../core/env.dart';
import 'common.dart';

class LinuxArmBuildCommand extends Command with BuildCommandCommonSteps {
  @override
  String get description => "Build Linux Arm";

  @override
  String get name => "linux_arm";

  @override
  FutureOr? run() async {
    await bootstrap();

    await shell.run(
      "docker buildx build --platform=linux/arm64 "
      "-f ${join(cwd.path, ".github", "Dockerfile")} ${cwd.path} "
      "--build-arg FLUTTER_VERSION=${CliEnv.flutterVersion} "
      "--build-arg BUILD_VERSION=${CliEnv.channel == BuildChannel.nightly ? "nightly" : versionWithoutBuildNumber} "
      "-t krtirtho/pyro_music_linux_arm:latest "
      "--load",
    );

    await shell.run(
      """
      docker images ls
      docker create --name pyro_music_linux_arm krtirtho/pyro_music_linux_arm:latest
      docker cp pyro_music_linux_arm:/app/dist/ dist/
      """,
    );
  }
}
