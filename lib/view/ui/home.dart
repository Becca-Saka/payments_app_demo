import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutterwave.dart';
import 'paystack.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: PageView(
            children: [
              PaystackScreen(),
              FlutterwaveScreen(),
            ],
          )),
      ),
    );
  }

 }
