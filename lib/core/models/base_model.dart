import 'package:flutter/foundation.dart';

/// Base class for all models in the application
@immutable
abstract class BaseModel {
  final String id;
  final String platform;

  const BaseModel({
    required this.id,
    required this.platform,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'platform': platform,
      };

  BaseModel copyWith({
    String? id,
    String? platform,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          platform == other.platform;

  @override
  int get hashCode => id.hashCode ^ platform.hashCode;
}
