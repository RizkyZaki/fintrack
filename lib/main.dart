import 'package:flutter/material.dart';
import 'package:fin_track/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kejari',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: "Poppins",
      ),
      home: Splash(),
    );
  }
}
