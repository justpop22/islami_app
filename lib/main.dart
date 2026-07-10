import 'package:flutter/material.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/layout/home.dart';
import 'package:islami/modules/splash_screen/splash_screen.dart';
import 'core/init_app.dart';
import 'modules/hadeth_details/hadeth_details.dart';
import 'modules/sura_details/sura_details.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await InitApp.initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routes: {
        SplashScreen.route : (_)=>SplashScreen(),
        Home.route : (_)=> Home(),
        SuraDetails.route : (_)=> SuraDetails(),
        HadethDetails.route : (_)=> HadethDetails(),
      },
    );
  }
}
