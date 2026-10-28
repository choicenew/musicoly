import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'entities/index.dart';

part 'isar_service.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(Ref ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [
      TrackEntitySchema,
      PlaylistEntitySchema,
      LyricsEntitySchema,
    ],
    directory: dir.path,
  );
}
