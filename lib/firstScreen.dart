import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.black,
          photoSize: 150,
          image: Image.asset("imag/payth.png"),
          seconds: 5,
          loaderColor: Colors.white,
          loadingText: Text('تحميل', style: TextStyle(color: Colors.white)),
          navigateAfterSeconds: MyApp(),
          title: Text(
            "تطبيق صلاتي\nمحمد الطويل ",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
