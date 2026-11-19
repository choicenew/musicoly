class PlatformServiceError implements Exception {
  final String code;
  final String message;
  final dynamic originalError;

  PlatformServiceError(this.code, this.message, [this.originalError]);

  factory PlatformServiceError.fromPlatformError(dynamic error) {
    if (error is PlatformServiceError) return error;
    return PlatformServiceError(
      'PLATFORM_ERROR',
      error?.toString() ?? 'An unknown platform error occurred.',
      error,
    );
  }

  @override
  String toString() => 'PlatformServiceError($code): $message';
}
