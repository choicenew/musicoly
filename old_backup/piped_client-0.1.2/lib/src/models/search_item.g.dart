// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PipedSearchItem _$PipedSearchItemFromJson(Map<String, dynamic> json) =>
    PipedSearchItem(
      url: json['url'] as String,
      type: $enumDecode(_$PipedSearchItemTypeEnumMap, json['type']),
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$PipedSearchItemToJson(PipedSearchItem instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': _$PipedSearchItemTypeEnumMap[instance.type]!,
      'thumbnail': instance.thumbnail,
    };

const _$PipedSearchItemTypeEnumMap = {
  PipedSearchItemType.stream: 'stream',
  PipedSearchItemType.channel: 'channel',
  PipedSearchItemType.playlist: 'playlist',
};
