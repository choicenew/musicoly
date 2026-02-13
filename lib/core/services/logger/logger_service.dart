import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class LogProcessor {
  Future<void> process(LogEntry entry);
}

class FileLogProcessor implements LogProcessor {
  final String _logFileName;
  final int _maxFileSize;
  final int _maxFileCount;

  FileLogProcessor({
    String logFileName = 'app.log',
    int maxFileSize = 1024 * 1024 * 5, // 5MB
    int maxFileCount = 3,
  })  : _logFileName = logFileName,
        _maxFileSize = maxFileSize,
        _maxFileCount = maxFileCount;

  Future<File> _getLogFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_logFileName');
  }

  Future<void> _rotateLogs() async {
    final file = await _getLogFile();
    if (await file.exists() && await file.length() > _maxFileSize) {
      for (var i = _maxFileCount - 1; i > 0; i--) {
        final oldFile = File('${file.path}.$i');
        if (await oldFile.exists()) {
          if (i == _maxFileCount - 1) {
            await oldFile.delete();
          } else {
            await oldFile.rename('${file.path}.${i + 1}');
          }
        }
      }
      await file.rename('${file.path}.1');
    }
  }

  @override
  Future<void> process(LogEntry entry) async {
    await _rotateLogs();
    final file = await _getLogFile();
    await file.writeAsString(
      '${entry.timestamp} [${entry.level}] ${entry.message}\n',
      mode: FileMode.append,
    );
  }
}

class LogEntry {
  final DateTime timestamp;
  final String level;
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  LogEntry({
    required this.level,
    required this.message,
    this.error,
    this.stackTrace,
  }) : timestamp = DateTime.now();
}

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  final List<LogProcessor> _processors = [];
  bool _verbose = false;

  factory LoggerService() => _instance;

  LoggerService._internal();

  void initialize({bool verbose = false, List<LogProcessor>? processors}) {
    _verbose = verbose;
    _processors.addAll(processors ?? []);
  }

  void addProcessor(LogProcessor processor) {
    _processors.add(processor);
  }

  Future<void> _log(LogEntry entry) async {
    if (!_verbose && entry.level == 'DEBUG') return;
    
    for (final processor in _processors) {
      await processor.process(entry);
    }
  }

  Future<void> debug(String message) => _log(LogEntry(level: 'DEBUG', message: message));
  Future<void> info(String message) => _log(LogEntry(level: 'INFO', message: message));
  Future<void> warning(String message) => _log(LogEntry(level: 'WARNING', message: message));
  Future<void> error(String message, [dynamic error, StackTrace? stack]) => 
    _log(LogEntry(level: 'ERROR', message: message, error: error, stackTrace: stack));
}