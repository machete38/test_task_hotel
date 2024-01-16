import 'package:json_annotation/json_annotation.dart';

part 'choose_hotel_model.g.dart';

@JsonSerializable()
class ChooseHotelModel {
  int id;
  String name;
  String adress;
  int minimal_price;
  String price_for_it;
  dynamic image_urls;
  int rating;
  String rating_name;
  Map<String, dynamic> about_the_hotel;

  ChooseHotelModel(
      {required this.id,
      required this.name,
      required this.adress,
      required this.minimal_price,
      required this.price_for_it,
      required this.image_urls,
      required this.rating,
      required this.rating_name,
      required this.about_the_hotel});

  factory ChooseHotelModel.fromJson(Map<String, dynamic> json) =>
      _$ChooseHotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChooseHotelModelToJson(this);
}
