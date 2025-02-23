import 'dart:async';
import 'package:fin_track/screen/auth/login.dart';
import 'package:fin_track/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(Splash());
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
    startScreen();
  }

  startScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      User? user = FirebaseAuth.instance.currentUser; // Cek user yang login
      if (user != null) {
        // Jika sudah login, masuk ke HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MyHomePage()),
        );
      } else {
        // Jika belum login, masuk ke LoginPage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.lightBlueAccent.withOpacity(0.5)],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Center(
                child: Image.asset("assets/images/logo.png", width: 150),
              ),
              ..._buildFloatingIcons(context),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Versi 1.0.0",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingIcons(BuildContext context) {
    final double iconSize = 60; // Increased icon size
    final double radius =
        160; // Increased radius to move icons further from the center
    final double centerX = MediaQuery.of(context).size.width / 2;
    final double centerY = MediaQuery.of(context).size.height / 2;

    // Icon data
    final List<String> iconPaths = [
      "assets/images/wallet.png",
      "assets/images/task.png",
      "assets/images/wallet2.png",
      "assets/images/confetti.png",
      "assets/images/emoji.png",
      "assets/images/hand.png",
    ];

    final random = Random();

    return List.generate(iconPaths.length, (index) {
      double angle = (2 * pi / iconPaths.length) * index;
      double offsetX = centerX + radius * cos(angle) - iconSize / 2;
      double offsetY = centerY + radius * sin(angle) - iconSize / 2;

      // Random rotation angle between -π/6 and π/6 radians (approx -30 to 30 degrees)
      double rotationAngle = (random.nextDouble() - 0.5) * pi / 6;

      return Positioned(
        left: offsetX,
        top: offsetY,
        child: Transform.rotate(
          angle: rotationAngle,
          child: Image.asset(
            iconPaths[index],
            width: iconSize,
            height: iconSize,
          ),
        ),
      );
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
