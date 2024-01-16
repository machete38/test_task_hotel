import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_hotel/models/choose_hotel_model.dart';
import 'package:test_hotel/pages/room.dart';
import 'package:test_hotel/service/api_service.dart';
import 'package:test_hotel/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final menu_list = [
    ["assets/icons/emoji-happy.png", "Удобства"],
    ["assets/icons/tick-square.png", "Что включено"],
    ["assets/icons/close-square.png", "Что не включено"]
  ];

  var posts = null;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppBar("Отель", arrow: false),
        bottomSheet: Material(
          elevation: 20,
          child: Container(
              color: Colors.white,
              child: actButton("К выбору номера", () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RoomPage(name: posts.name)));
              })),
        ),
        body: posts == null ? _body() : _posts(posts));
  }

  FutureBuilder _body() {
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: apiService.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error" + snapshot.error.toString());
            }
            posts = snapshot.data!;
            return _posts(posts);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _posts(ChooseHotelModel posts) {
    return SafeArea(
        child: defaultBody([
      roundedContainer(false, [
        imgStack((int page) {
          setState(() {
            posts = posts;
            currentIndex = page;
          });
        }, currentIndex, posts.image_urls),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: hotelInfo(
              posts.rating, posts.rating_name, posts.name, posts.adress),
        ),
        stPriceContainer(posts.minimal_price, posts.price_for_it)
      ]),
      Container(
        margin: EdgeInsets.only(bottom: 50),
        child: roundedContainer(true, [
          Container(
            margin: EdgeInsets.only(top: 16, left: 16),
            child: Text(
              "Об отеле",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 5),
              child: wrapObj(posts.about_the_hotel["peculiarities"])),
          Container(
            margin: EdgeInsets.only(left: 16, top: 10, right: 10),
            child: Text(
              posts.about_the_hotel["description"],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            child: Column(
              children: _buildMenu(),
            ),
            decoration: BoxDecoration(
                color: Color(0xFFFBFBFC),
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          )
        ]),
      )
    ]));
  }

  List<Widget> _buildMenu() {
    List<Widget> list = [];
    for (int i = 0; i < menu_list.length; i++) {
      list.add(_wrapMenu(menu_list[i][0], menu_list[i][1]));
      if (i + 1 != menu_list.length) {
        list.add(Divider(
          indent: 50,
          endIndent: 20,
        ));
      }
    }
    return list;
  }

  Widget _wrapMenu(img, text) {
    return Container(
        margin: EdgeInsets.only(
          top: 5,
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            Image(image: AssetImage(img)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )),
                  Text("Самое необходимое",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF828796),
                      ))
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(right: 15),
              child: Image(image: AssetImage("assets/icons/arrow.png")),
            )
          ],
        ));
  }
}
