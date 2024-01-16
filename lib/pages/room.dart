import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_hotel/pages/booking.dart';
import 'package:test_hotel/service/api_service.dart';
import 'package:test_hotel/widgets/widgets.dart';

class RoomPage extends StatefulWidget {
  final String name;
  RoomPage({super.key, required this.name});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  var list = {
    "номера": [
      {
        "идентификатор": 1,
        "name": "Стандартный номер с видом на бассейн",
        "цена": 186600,
        "price_per": "За 7 ночей с перелетом",
        "особенности": ["Включен только завтрак", "Кондиционер"],
        "image_urls": [
          "https://www.atorus.ru/sites/default/files/upload/image/News/56871/%D1%80%D0%B8%D0%BA%D1%81%D0%BE%D1%81% 20%D1%81%D0%B8%D0%B3%D0%B5%D0%B9%D1%82.jpg",
          "https://gogolhotel.ru/images/r4.jpg",
          "https://worlds-trip.ru/wp-content/uploads/2022/10/white-hills-resort-5.jpeg"
        ]
      },
      {
        "идентификатор": 2,
        "name": "Люкс номер с видом на море",
        "цена": 289400,
        "price_per": "За 7 ночей с перелетом",
        "особенности": ["Все включено", "Кондиционер", "Собственный бассейн"],
        "image_urls": [
          "https://mmf5angy.twic.pics/ahstatic/www.ahstatic.com/photos/b1j0_roskdc_00_p_1024x768.jpg?ritok=65&twic=v1/cover=800x600",
          "https://idei.club/raznoe/uploads/posts/2022-12/thumbs/1671660872_idei-club-p-eksterer-i-interer-gostinitsi-dizain-oboi-88.jpg",
          "https://tour-find.ru/thumb/2/bsb2EIEFA8nm22MvHqMLlw/r/d/screenshot_3_94.png"
        ]
      }
    ]
  };
  var rooms = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppBar(widget.name),
        body: _rooms(list['номера'], context));
  }

  FutureBuilder _body() {
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: apiService.getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error" + snapshot.error.toString());
            }
            rooms = snapshot.data!;
            return _rooms(rooms, context);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

Widget _rooms(rooms, context) {
  return SafeArea(
      child: defaultBody([
    Table(
      children: _createHotelWidgets(rooms, context),
    )
  ]));
}

List<TableRow> _createHotelWidgets(rooms, context) {
  List<TableRow> list = [];
  for (int i = 0; i < rooms.length; i++) {
    list.add(hotelW(rooms[i], context));
  }
  return list;
}

class ImgWidget extends StatefulWidget {
  final List<String> image_urls;
  ImgWidget({super.key, required this.image_urls});

  @override
  State<ImgWidget> createState() => _ImgWidgetState();
}

class _ImgWidgetState extends State<ImgWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return imgStack((int page) {
      setState(() {
        currentIndex = page;
      });
    }, currentIndex, widget.image_urls);
  }
}

TableRow hotelW(room, context) {
  return TableRow(children: [
    roundedContainer(true, [
      ImgWidget(image_urls: room["image_urls"]),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          room["name"],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: wrapObj(room["особенности"]),
      ),
      Container(
        margin: EdgeInsets.only(left: 16),
        child: textContainer(Color(0xFF0D72FF).withOpacity(0.1), [
          Text(
            "Подробнее о номере",
            style: TextStyle(
                color: Color(0xFF0D72FF),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Image(
                image: AssetImage("assets/icons/arrow.png"),
                color: Color(0xFF0D72FF)),
          ),
        ]),
      ),
      stPriceContainer(room["цена"], room["price_per"]),
      actButton("Выбрать номер", () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BookingPage()));
      })
    ])
  ]);
}
