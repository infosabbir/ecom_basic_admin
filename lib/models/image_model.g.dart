// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageModelImpl _$$ImageModelImplFromJson(Map<String, dynamic> json) =>
    _$ImageModelImpl(
      imageId: json['imageId'] as String?,
      imageName: json['imageName'] as String,
      directoryName: json['directoryName'] as String,
      downloadUrl: json['downloadUrl'] as String,
    );

Map<String, dynamic> _$$ImageModelImplToJson(_$ImageModelImpl instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imageName': instance.imageName,
      'directoryName': instance.directoryName,
      'downloadUrl': instance.downloadUrl,
    };
