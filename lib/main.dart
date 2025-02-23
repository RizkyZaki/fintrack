import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fin_track/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (_) => AuthBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fintrack',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: "Poppins",
      ),
      home: Splash(),
    );
  }
}
