// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choose_hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChooseHotelModel _$ChooseHotelModelFromJson(Map<String, dynamic> json) =>
    ChooseHotelModel(
      id: json['id'] as int,
      name: json['name'] as String,
      adress: json['adress'] as String,
      minimal_price: json['minimal_price'] as int,
      price_for_it: json['price_for_it'] as String,
      image_urls: json['image_urls'],
      rating: json['rating'] as int,
      rating_name: json['rating_name'] as String,
      about_the_hotel: json['about_the_hotel'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ChooseHotelModelToJson(ChooseHotelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adress': instance.adress,
      'minimal_price': instance.minimal_price,
      'price_for_it': instance.price_for_it,
      'image_urls': instance.image_urls,
      'rating': instance.rating,
      'rating_name': instance.rating_name,
      'about_the_hotel': instance.about_the_hotel,
    };
