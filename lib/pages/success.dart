import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_hotel/pages/home.dart';
import 'package:test_hotel/widgets/widgets.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: buttonBotom(context, "Супер!", HomePage()),
        appBar: defaultAppBar("Заказ оплачен"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xFFF6F6F9), shape: BoxShape.circle),
                    child: Text(
                      "🎉",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: customText(
                        "Ваш заказ принят в работу", TextType.black500, 22),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: customText(
                        "Подтверждение заказа №${Random().nextInt(99999) + 100000} может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.",
                        TextType.grey400,
                        16),
                  )
                ],
              ),
            )),
          ],
        ));
  }
}
