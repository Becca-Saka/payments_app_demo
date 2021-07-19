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

class PaystackScreen extends StatefulWidget {
  @override
  _PaystackScreenState createState() => _PaystackScreenState();
}

class _PaystackScreenState extends State<PaystackScreen> {
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
                provider: 'Paystack',
              ),
              PaymentDetails(
                paystackCheckout:()=> _handleCheckout(context), provider: 'Paystack',
              ),
               ],
          ),
        ),
      ),
    );
  }

  _handleCheckout(BuildContext context) async {
    setState(() => _inProgress = true);
    Charge charge = Charge()
      ..amount = 100 // In base currency
      ..email = 'beccasaka@email.com'
      ..card = PaymentCard(
        number: SampleBankCards.paystackCard,
        cvc: SampleBankCards.paystackCardCvv,
        expiryMonth: 07,
        expiryYear: 22,
      );
    var accessCode = await _fetchAccessCodeFrmServer(_getReference());
    charge.accessCode = accessCode;

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.selectable,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      _updateStatus(response.reference, '$response');
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Check console for error");
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  String backendUrl = 'https://beccapaymentapp.herokuapp.com';

  Future<String?> _fetchAccessCodeFrmServer(String reference) async {
    String url = '$backendUrl/new-access-code';
    String? accessCode;
    try {
      print("Access code url = $url");
      http.Response response = await http.get(Uri.parse(url));
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      setState(() => _inProgress = false);
      _updateStatus(
          reference,
          'There was a problem getting a new access code form'
          ' the backend: $e');
    }

    return accessCode;
  }

  void _verifyOnServer(String? reference) async {
    _updateStatus(reference, 'Verifying...');
    String url = '$backendUrl/verify/$reference';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var body = response.body;
      _updateStatus(reference, body);
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem verifying %s on the backend: '
          '$reference $e');
    }
    setState(() => _inProgress = false);
  }

  _updateStatus(String? reference, String message) {
    _showMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
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
