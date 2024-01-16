import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:test_hotel/models/booking_model.dart';
import 'package:test_hotel/models/choose_hotel_model.dart';
import 'package:test_hotel/models/room_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://run.mocky.io/v3/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('d144777c-a67f-4e35-867a-cacc3b827473')
  Future<ChooseHotelModel> getPosts();

  @GET('e28ae1b9-2033-4d13-83e0-9f6c046b2f4a')
  Future<List<RoomModel>> getRooms();

  @GET('63866c74-d593-432c-af8e-f279d1a8d2ff')
  Future<BookingModel> getBookingInfo();
}
