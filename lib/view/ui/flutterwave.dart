import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:paymentapp/core/api_keys.dart';
import 'package:paymentapp/core/cards.dart';
import 'package:paymentapp/view/widgets/credit_card.dart';
import 'package:paymentapp/view/widgets/payment_widget.dart';

class FlutterwaveScreen extends StatefulWidget {
  @override
  _FlutterwaveScreenState createState() => _FlutterwaveScreenState();
}

class _FlutterwaveScreenState extends State<FlutterwaveScreen> {
  final plugin = PaystackPlugin();
  bool _inProgress = false;

  @override
  void initState() {
    plugin.initialize(publicKey: ApiKeys.paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              SampleCard(
                provider: 'FlutterWave',
              ),
              PaymentDetails(
                flutterwaveCheckout:(){

                 showMessage('Not Implemented yet');
                 }, provider: 'FlutterWave',
                ), 
              ],
          ),
        ),
      ),
    );
  }

 
   showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "PA",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

const Color green = const Color(0xFF3db76d);
const Color lightBlue = const Color(0xFF34a5db);
const Color navyBlue = const Color(0xFF031b33);
