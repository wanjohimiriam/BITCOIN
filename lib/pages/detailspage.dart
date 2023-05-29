// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map rate;
  const DetailsPage({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    List currencies = rate.keys.toList();
    List _exchangeRates = rate.values.toList();
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                String currency = currencies[index].toString().toUpperCase();
                String _exchangeRate =
                    _exchangeRates[index].toString().toUpperCase();
                return ListTile(
                    title: Text("$currency : $_exchangeRate",
                        style: TextStyle(color: Colors.white)));
              })),
    );
  }
}
