import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:collection/collection.dart';

/// Downloading by spiting as file in chunks
extension ChunkDownload on Dio {
  Future<Response> chunkedDownload(
    url, {
    Map<String, dynamic>? queryParameters,
    required String savePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    int chunkSize = 102400, // 100KB
    int maxConcurrentChunk = 3,
    String tempExtension = ".temp",
  }) async {
    int total = 0;
    var progress = <int>[];

    ProgressCallback createCallback(int chunkIndex) {
      return (int received, _) {
        progress[chunkIndex] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    // this is the last response
    // status & headers will the last chunk's status & headers
    final completer = Completer<Response>();

    Future<Response> downloadChunk(
      String url, {
      required int start,
      required int end,
      required int chunkIndex,
    }) async {
      progress.add(0);
      --end;
      final res = await download(
        url,
        savePath + tempExtension + chunkIndex.toString(),
        onReceiveProgress: createCallback(chunkIndex),
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        deleteOnError: deleteOnError,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {"range": "bytes=$start-$end"},
        ),
      );

      return res;
    }

    Future<void> mergeTempFiles(int chunk) async {
      File headFile = File("$savePath${tempExtension}0");
      var raf = await headFile.open(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File chunkFile = File(savePath + tempExtension + i.toString());
        raf = await raf.writeFrom(await chunkFile.readAsBytes());
        await chunkFile.delete();
      }
      await raf.close();

      headFile = await headFile.rename(savePath);
    }

    final firstResponse = await downloadChunk(
      url,
      start: 0,
      end: chunkSize,
      chunkIndex: 0,
    );

    final responses = <Response>[firstResponse];

    if (firstResponse.statusCode == HttpStatus.partialContent) {
      total = int.parse(
        firstResponse.headers
                .value(HttpHeaders.contentRangeHeader)
                ?.split("/")
                .lastOrNull ??
            '0',
      );

      final reserved = total -
          int.parse(
            firstResponse.headers.value(HttpHeaders.contentLengthHeader) ??
                // since its a partial content, the content length will be the chunk size
                chunkSize.toString(),
          );

      int chunk = (reserved / chunkSize).ceil() + 1;

      if (chunk > 1) {
        int currentChunkSize = chunkSize;
        int start = currentChunkSize;

        final futures = <Future<Response>>[];

        for (int i = 1; i < chunk; ++i) {
          if (i == chunk - 1) {
            currentChunkSize = reserved % chunkSize;
            if (currentChunkSize == 0) {
              currentChunkSize = chunkSize;
            }
          }

          final end = start + currentChunkSize;

          if (futures.length == maxConcurrentChunk) {
            final res = await futures.removeAt(0);
            responses.add(res);
          }

          futures.add(
            downloadChunk(
              url,
              start: start,
              end: end,
              chunkIndex: i,
            ),
          );

          start = end;
        }

        if (futures.isNotEmpty) {
          final res = await Future.wait(futures);
          responses.addAll(res);
        }
      }

      await mergeTempFiles(chunk);

      return responses.last;
    } else {
      await File(savePath + tempExtension + "0").rename(savePath);
      return firstResponse;
    }
  }
}
