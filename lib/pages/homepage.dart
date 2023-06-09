// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:convert';

import 'package:bitcoin/pages/detailspage.dart';
import 'package:bitcoin/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? dev_width, dev_height;
  String _selectedCoin = "bitcoin";

  HTTPService? _http;
  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) {
    dev_width = MediaQuery.of(context).size.width;
    dev_height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [_selectedDropDown(), _widgetData()],
        ),
      )),
    );
  }

  Widget _selectedDropDown() {
    List<String> _coins = [
      "bitcoin",
      "ethereum",
      "tether",
      "cardano",
      "ripple"
    ];
    List<DropdownMenuItem> _items = _coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
        .toList();
    return DropdownButton(
      value: _selectedCoin,
      iconSize: 30,
      dropdownColor: Color.fromRGBO(83, 88, 206, 1.0),
      items: _items,
      onChanged: (_value) {
        setState(() {
          _selectedCoin = _value;
        });
      },
      icon: Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
      ),
      underline: Container(),
    );
  }

  Widget _widgetData() {
    return FutureBuilder(
        future: _http!.get("/coins/$_selectedCoin"),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            Map _data = jsonDecode(_snapshot.data.toString());
            num _usdPrice = _data["market_data"]["current_price"]["usd"];
            num _change24 = _data["market_data"]["price_change_percentage_24h"];
            Map _exchangeRates = _data["market_data"]["current_price"];
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return DetailsPage(
                          rate: _exchangeRates,
                        );
                      }));
                    },
                    child: coin_image_Widget(_data["image"]["large"])),
                current_rate_Price(_usdPrice),
                percentage_changeNum(_change24),
                description_card_widget(_data["description"]['en'])
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }

  Widget current_rate_Price(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)}USD",
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget percentage_changeNum(num _change) {
    return Text(
      "${_change.toString()}%",
      style: TextStyle(
          color: Colors.white54, fontSize: 20, fontWeight: FontWeight.w300),
    );
  }

  Widget coin_image_Widget(String img_url) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: dev_height! * 0.02,
      ),
      height: dev_height! * 0.15,
      width: dev_width! * 0.15,
      decoration:
          BoxDecoration(image: DecorationImage(image: NetworkImage(img_url))),
    );
  }

  Widget description_card_widget(String _description) {
    return Container(
      height: dev_height! * 0.45,
      width: dev_width! * 0.90,
      padding: EdgeInsets.symmetric(
        vertical: dev_height! * 0.01,
        horizontal: dev_width! * 0.01,
      ),
      margin: EdgeInsets.symmetric(
        vertical: dev_height! * 0.02,
      ),
      color: Color.fromRGBO(83, 88, 206, 0.5),
      child: Text(
        _description,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
