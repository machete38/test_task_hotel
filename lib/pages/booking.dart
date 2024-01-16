import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_hotel/models/booking_model.dart';
import 'package:test_hotel/pages/success.dart';
import 'package:test_hotel/service/api_service.dart';
import 'package:test_hotel/widgets/widgets.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int touristCount = 1;

  var bkInfo = null;

  @override
  Widget build(BuildContext context) {
    return bkInfo == null ? _body() : _booking(bkInfo);
  }

  FutureBuilder _body() {
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: apiService.getBookingInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error" + snapshot.error.toString());
            }
            bkInfo = snapshot.data!;
            return _booking(bkInfo);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _booking(BookingModel bkInfo) {
    return Scaffold(
        appBar: defaultAppBar("Бронирование"),
        body: defaultBody([
          roundedContainer(padding: true, true, [
            hotelInfo(bkInfo.horating, bkInfo.rating_name, bkInfo.hotel_name,
                bkInfo.hotel_adress),
          ]),
          roundedContainer(padding: true, true, bookingInfoW(bkInfo, false)),
          roundedContainer(padding: true, true, [userInfoW()]),
          Column(children: touristWidgets(touristCount)),
          InkWell(
            onTap: () {
              setState(() {
                if (touristCount != 6) {
                  touristCount++;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text("В этот номер может въехать максимум 6 туристов"),
                  ));
                }
              });
            },
            child: roundedContainer(padding: true, true, [
              Row(
                children: [
                  customText("Добавить туриста", TextType.black500, 22),
                  Spacer(),
                  btContainer(Icon(Icons.add, color: Colors.white, size: 25),
                      Color(0xFF0D72FF))
                ],
              )
            ]),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 90),
            child: roundedContainer(
                padding: true, true, bookingInfoW(bkInfo, true)),
          )
        ]),
        bottomSheet: buttonBotom(
            context,
            "Оплатить ${bkInfo.tour_price + bkInfo.fuel_charge + bkInfo.service_charge} ₽",
            SuccessPage()));
  }
}
