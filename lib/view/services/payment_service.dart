
import 'dart:developer';
import 'dart:io';

import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
/*for paystack
Server was deployed using paystck sample at https://github.com/PaystackHQ/sample-charge-card-backend
*/
class PaymentService {
  
  final plugin = PaystackPlugin();
  String paystckBackendUrl = 'https://beccapaymentapp.herokuapp.com';

   String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String?> fetchAccessCodeFrmServer(String reference) async {
    String url = '$paystckBackendUrl/new-access-code';
    String? accessCode;
    try {
      print("Access code url = $url");
      http.Response response = await http.get(Uri.parse(url));
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      log('$reference There was a problem getting a new access code form'
          ' the backend: $e');
    }

    return accessCode;
  }

  void verifyOnServer(String? reference) async {
    log('$reference, Verifying...');
    String url = '$paystckBackendUrl/verify/$reference';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var body = response.body;
      log('$reference,  $body');
    } catch (e) {
      log('$reference, There was a problem verifying %s on the backend: '
          '$reference $e');
    }
  }
}
