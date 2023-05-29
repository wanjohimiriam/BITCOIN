// ignore_for_file: prefer_const_constructors

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
        children: [_selectedDropDown()],
      ),
          )),
    );
  }

  Widget _selectedDropDown() {
    List<String> _coins = ["bitcoin"];
    List<DropdownMenuItem> _items = _coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w600
            ),),
          ),
        )
        .toList();
    return DropdownButton(
      value: _coins.first,
      iconSize: 30,
      dropdownColor: Color.fromRGBO(83, 88, 206, 1.0),
      items: _items, onChanged: (_value) {},
      icon: Icon(Icons.arrow_drop_down_sharp,
      color: Colors.white,),
      underline: Container(),
      );
  }
}
