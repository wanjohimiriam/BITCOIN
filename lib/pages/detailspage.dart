// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //late List <String> _dat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: ListView.builder(
          itemCount:10 ,
          itemBuilder: (context, int index){
            return Container();
          }
        )),
    );
  }
}