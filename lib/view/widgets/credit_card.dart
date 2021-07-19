import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymentapp/core/cards.dart';
import 'package:paymentapp/view/shared/const_color.dart';
import 'package:paymentapp/view/shared/const_size.dart';
import 'package:paymentapp/view/shared/const_spacing.dart';

final cardBgColor = const Color(0xff1b447b);
final backgroundGradientColor = LinearGradient(
  // Where the linear gradient begins and ends
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: const <double>[0.1, 0.4, 0.7, 0.9],
  colors: <Color>[
    cardBgColor.withOpacity(1),
    cardBgColor.withOpacity(0.97),
    cardBgColor.withOpacity(0.90),
    cardBgColor.withOpacity(0.86),
  ],
);

class SampleCard extends StatelessWidget {
  final String provider;
  const SampleCard({Key? key, required this.provider}) : super(key: key);

  splitNumber(String text) {
    if (text.length == 0) {
      return text;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('    '); // Add double spaces.
      }
    }

    var newValue = buffer.toString();
    return newValue;
  }

  Color getCardBackGround() {
    Color color = Colors.transparent;
    switch (provider) {
      case 'Paystack':
        color = AppColors.paystackPrimaryColor;
        break;
      case 'FlutterWave':
        color = AppColors.flutterWavePrimaryColor;
        break;
      default:
    }
    return color;
  }

  String getCardnumber() {
    String cardno = '';
    switch (provider) {
      case 'Paystack':
        cardno = SampleBankCards.paystackCard;
        break;
      case 'FlutterWave':
        cardno = SampleBankCards.paystackCard;
        break;
      default:
    }
    return cardno;
  }

  String getCardCvv() {
    String cardno = '';
    switch (provider) {
      case 'Paystack':
        cardno = SampleBankCards.paystackCardCvv;
        break;
      case 'FlutterWave':
        cardno = SampleBankCards.paystackCardCvv;
        break;
      default:
    }
    return cardno;
  }

  String getCardExp() {
    String cardno = '';
    switch (provider) {
      case 'Paystack':
        cardno = SampleBankCards.paystackCardExp;
        break;
      case 'FlutterWave':
        cardno = SampleBankCards.paystackCardExp;
        break;
      default:
    }
    return cardno;
  }

  Widget getCardLogo() {
    Widget cardno = Container();
    switch (provider) {
      case 'Paystack':
        cardno = ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/images/paystack.png',
              ),
            ));
        break;
      case 'FlutterWave':
        cardno = ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/images/flutterwave.png',
                fit: BoxFit.cover,
              ),
            ));
        break;
      default:
    }
    return cardno;
  }

  Container buildFrontContainer(
    BuildContext context,
    Orientation orientation,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: getCardBackGround(),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MySize.xMargin(context, 100),
      height: (orientation == Orientation.portrait
          ? MySize.yMargin(context, 30)
          : MySize.yMargin(context, 50)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: SizedBox(
                  width: MySize.xMargin(context, 30),
                  height: MySize.yMargin(context, 3.5),
                  child: getCardLogo(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MySize.xMargin(context, 15),
                height: MySize.xMargin(context, 15),
                child: Image.asset(
                  'assets/images/chip.png',
                ),
              ),
            ),
            smallHeight(context),
            Text(
              splitNumber(getCardnumber()),
              style: TextStyle(
                  fontSize: MySize.textSize(context, 6), color: Colors.white),
            ),
            smallHeight(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Expires \n end of',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: MySize.textSize(context, 3),
                      color: Colors.white),
                ),
                smallWidth(context),
                Text(
                  getCardExp(),
                  style: TextStyle(
                      fontSize: MySize.textSize(context, 3),
                      color: Colors.white),
                ),
              ],
            ),
            smallHeight(context),
            smallHeight(context),
            Text(
              'Sample User',
              style: TextStyle(
                  fontSize: MySize.textSize(context, 5), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildFrontContainer(context, Orientation.portrait);
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
