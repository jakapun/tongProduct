import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tongproduct/screens/authen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      home: Authen(),
    );
  }
}