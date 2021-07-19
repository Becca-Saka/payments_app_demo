import 'package:flutter/material.dart';
import 'package:paymentapp/view/shared/const_color.dart';
import 'package:paymentapp/view/shared/const_size.dart';
import 'package:paymentapp/view/shared/const_spacing.dart';

class PaymentDetails extends StatelessWidget {
  final Function? paystackCheckout;
  final Function? flutterwaveCheckout;
  final String provider;
  const PaymentDetails({Key? key, required this.provider, this.paystackCheckout, this.flutterwaveCheckout})
      : super(key: key);
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

  getOnPressed(){

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            minHeight(context),
            Text(
              'You are paying for',
              style: TextStyle(
                fontSize: MySize.textSize(context, 6),
              ),
            ),
            smallHeight(context),
            Text('Electricity',
                style: TextStyle(
                    fontSize: MySize.textSize(context, 6),
                    fontWeight: FontWeight.bold)),
            smallHeight(context),
            Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Amount \n \$100',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MySize.textSize(context, 4.5),
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: MySize.yMargin(context, 12),
                  child: VerticalDivider(
                    color: Colors.black,
                  ),
                ),
                Text('Charges \n \$0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MySize.textSize(context, 4.5),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
        smallHeight(context),
        Text('Total \n \$100',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MySize.textSize(context, 6),
                fontWeight: FontWeight.bold)),
        minHeight(context),
        minHeight(context),
        InkWell(
          onTap: () {
            provider =='Paystack'? paystackCheckout!():flutterwaveCheckout!();
          },
          child: Container(
            height: 50,
            width: MySize.xMargin(context, 70),
            decoration: BoxDecoration(
                color: getCardBackGround(),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text('Checkout',
                    style: TextStyle(
                      fontSize: MySize.textSize(context, 4),
                      color: Colors.white,
                    ))),
          ),
        )
      ],
    );
  }
}
