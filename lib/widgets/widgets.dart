import 'package:flutter/material.dart';
import 'package:test_hotel/models/booking_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum TextType { black500, grey400, blue500, black400 }

List<Widget> _buildWE(wr_list) {
  List<Widget> list = [];
  for (int i = 0; i < wr_list.length; i++) {
    list.add(_wrapEl(wr_list[i]));
  }
  return list;
}

Widget roundedContainer(bool topRadius, children, {bool padding = false}) {
  return Container(
      padding: padding ? EdgeInsets.all(16) : null,
      width: double.infinity,
      margin: topRadius
          ? EdgeInsets.only(top: 10, bottom: 10)
          : EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: topRadius
              ? BorderRadius.vertical(
                  top: Radius.circular(12), bottom: Radius.circular(12))
              : BorderRadius.vertical(bottom: Radius.circular(12))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children));
}

Widget _wrapEl(text) {
  return Container(
      margin: EdgeInsets.only(
        top: 5,
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFBFBFC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF828796),
          )));
}

Widget textContainer(color, children) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
  );
}

Widget defaultBody(children) {
  return SingleChildScrollView(
    child: Container(
      color: Color(0xFFF6F6F9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}

Widget buttonBotom(context, text, page) {
  return Material(
    elevation: 20,
    child: Container(
        color: Colors.white,
        child: actButton(text, () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => page));
        })),
  );
}

List<Widget> touristWidgets(int count) {
  List<Widget> list = [];
  for (int i = 0; i < count; i++) {
    list.add(touristWidget(num: i));
  }
  return list;
}

Widget btContainer(child, color) {
  return Container(
    width: 40,
    height: 40,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
    child: Center(child: child),
  );
}

class touristWidget extends StatefulWidget {
  int num;
  touristWidget({super.key, required this.num});

  @override
  State<touristWidget> createState() => _touristWidgetState(num: num);
}

class _touristWidgetState extends State<touristWidget> {
  int num;
  bool state = false;
  _touristWidgetState({required this.num}) {
    state = num == 0;
  }

  var str = ["Первый", "Второй", "Третий", "Четвёртый", "Пятый", "Шестой"];

  @override
  Widget build(BuildContext context) {
    return roundedContainer(padding: true, true, [
      InkWell(
        onTap: () {
          setState(() {
            state = !state;
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                customText("${str[widget.num]} турист", TextType.black500, 22),
                Spacer(),
                btContainer(
                    Icon(
                      state
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Color(0xFF0D72FF),
                      size: 25,
                    ),
                    Color(0xFF0D72FF).withOpacity(0.1))
              ],
            ),
            Visibility(
              visible: state,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    customTextField("Имя"),
                    customTextField("Фамилия"),
                    customTextField("Дата рождения"),
                    customTextField("Гражданство"),
                    customTextField("Номер загранпаспорта"),
                    customTextField("Срок действия загранпаспорта"),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }
}

Widget customTextField(hint,
    {isPhoneNum = false, stateChangerTrue, stateChangerFalse}) {
  var controller = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);
  return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xFFF6F6F9), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: isPhoneNum ? controller : null,
        inputFormatters: isPhoneNum ? [maskFormatter] : null,
        keyboardType: isPhoneNum ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: hint,
          hintText: isPhoneNum ? "(***) ***-**-**" : null,
          prefixText: isPhoneNum ? "+7 " : null,
          labelStyle: TextStyle(color: Color(0xFFA9ABB7), fontSize: 17),
          border: InputBorder.none,
        ),
      ));
}

Widget userInfoW() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: customText("Информация о покупателе", TextType.black500, 22)),
      customTextField("Номер телефона", isPhoneNum: true),
      customTextField("Почта"),
      customText(
          "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту",
          TextType.grey400,
          14)
    ],
  );
}

List<Widget> bookingInfoW(BookingModel list, bool withPrice) {
  List<Widget> list2 = [];
  if (!withPrice) {
    list2.add(infoW("Вылет из", list.departure));
    list2.add(infoW("Страна, город", list.arrival_country));
    list2.add(infoW("Даты", "${list.tour_date_start}-${list.tour_date_stop}"));
    list2.add(infoW("Кол-во ночей", "${list.number_of_nights} ночей"));
    list2.add(infoW("Отель", list.hotel_name));
    list2.add(infoW("Номер", list.room));
    list2.add(infoW("Питание", list.nutrition));
  } else {
    list2.add(infoW("Тур", list.tour_price, withPrice: true));
    list2.add(infoW("Топливный сбор", list.fuel_charge, withPrice: true));
    list2.add(infoW("Сервисный сбор", list.service_charge, withPrice: true));
    list2.add(infoW(
        "К оплате", list.tour_price + list.fuel_charge + list.service_charge,
        withPrice: true, special: true));
  }
  return list2;
}

Widget infoW(key, value, {withPrice = false, special = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: withPrice
          ? [
              Container(
                  width: 150, child: customText(key, TextType.grey400, 16)),
              Spacer(),
              customText("${value.toString()} ₽",
                  special ? TextType.blue500 : TextType.black400, 16)
            ]
          : [
              Container(
                  width: 150, child: customText(key, TextType.grey400, 16)),
              Flexible(
                  child: customText(value.toString(), TextType.black400, 16))
            ],
    ),
  );
}

Widget actButton(text, onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 50,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      margin: EdgeInsets.fromLTRB(15, 10, 15, 25),
      decoration: BoxDecoration(
          color: Color(0xFF0D72FF), borderRadius: BorderRadius.circular(15)),
      width: double.infinity,
    ),
  );
}

Widget stPriceContainer(str1, str2) {
  return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "от $str1 ₽",
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Flexible(
              child: Container(
            padding: EdgeInsets.only(bottom: 5, left: 5),
            child: Text(
              str2,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF828796),
                  fontWeight: FontWeight.w400),
            ),
          ))
        ],
      ));
}

Widget customText(String text, TextType type, double fontSize) {
  return Text(text,
      overflow: TextOverflow.clip,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: (type == TextType.grey400 || type == TextType.black400)
            ? FontWeight.w400
            : FontWeight.w500,
        color: (type == TextType.black500 || type == TextType.black400)
            ? Colors.black
            : type == TextType.blue500
                ? Color(0xFF0D72FF)
                : Color(0xFF828796),
      ));
}

PreferredSizeWidget defaultAppBar(text, {arrow = true}) {
  return AppBar(
    automaticallyImplyLeading: arrow,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
  );
}

Widget wrapObj(list) {
  return Wrap(spacing: 5, runSpacing: 5, children: _buildWE(list));
}

Widget hotelInfo(rating, rating_name, name, address) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textContainer(Color(0XFFFFC700).withOpacity(0.2), [
        Image(image: AssetImage('assets/icons/star.png')),
        Text("$rating $rating_name",
            style: TextStyle(
                color: Color(0XFFFFC700),
                fontWeight: FontWeight.w500,
                fontSize: 16))
      ]),
      Container(
        padding: EdgeInsets.fromLTRB(0, 5, 15, 5),
        child: Text(
          name,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Text(
          address,
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFF0D72FF),
              fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}

List<Widget> _buildImgList(imgList) {
  List<Widget> list = [];
  for (int i = 0; i < imgList.length; i++) {
    list.add(Image.network(imgList[i], fit: BoxFit.fill));
  }
  return list;
}

List<Widget> _buildPageIndicator(items, currentIndex) {
  List<Widget> list = [];
  for (int i = 0; i < items.length; i++) {
    list.add(i == currentIndex ? _indicator(true) : _indicator(false));
  }
  return list;
}

Widget _indicator(bool isActive) {
  return Container(
    height: 10,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: isActive ? 10 : 8.0,
      width: isActive ? 12 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.black : Color(0XFFEAEAEA),
      ),
    ),
  );
}

Widget imgStack(onPageChanged, currentIndex, img_urls) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
          margin: EdgeInsets.all(15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.grey,
          ),
          width: double.infinity,
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                child: PageView(
              onPageChanged: onPageChanged,
              children: _buildImgList(img_urls),
            )),
          )),
      Positioned(
          bottom: 30,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildPageIndicator(img_urls, currentIndex)),
          ))
    ],
  );
}
