import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget sayfa;

  const SplashScreen({
    Key? key,
    required this.sayfa,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Splash ekranı görüntülendikten sonra 2 saniye bekleyip diğer ekrana geçiş yapacak
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.sayfa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 2,
            width: size.height / 2,
            child: Image.asset('assets/logo/logom.png'),
          ),
          const SizedBox(height: 50),
          const SizedBox(height: 50),
          const CircularProgressIndicator(
            color: Colors.indigo,
          )
        ],
      )),
    );
  }
}
