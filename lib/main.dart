import 'package:flutter/material.dart';

import 'view/paystack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Payments Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainHome(),
    );
  }
}

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter payment demo'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height / 3,
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaystackPage()));
                    },
                    child: ColoredBox(
                      color: Colors.blue,
                      child: Center(child: Text('Paystack')),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => PaystackPage()));
                    },
                    child: ColoredBox(
                      color: Colors.green,
                      child: Center(child: Text('FlutterWave')),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
