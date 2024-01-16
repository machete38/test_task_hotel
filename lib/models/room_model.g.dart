// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      id: json['идентификатор'] as int,
      name: json['name'] as String,
      price: json['цена'] as int,
      price_per: json['price_per'] as String,
      offers: json['особенности'],
      image_urls: json['image_urls'],
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'идентификатор': instance.id,
      'name': instance.name,
      'цена': instance.price,
      'price_per': instance.price_per,
      'особенности': instance.offers,
      'image_urls': instance.image_urls,
    };
