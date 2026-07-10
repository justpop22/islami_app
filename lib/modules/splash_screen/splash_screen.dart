import 'package:flutter/material.dart';
import 'package:islami/core/theme/app_colors.dart';

import '../layout/home.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, Home.route, (_)=> false);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(child: Image.asset("assets/images/app_logo.png")),
            Spacer(),
            Image.asset("assets/images/route.png",width: 250,),
          ],
        ),
      ),
    );
  }
}
