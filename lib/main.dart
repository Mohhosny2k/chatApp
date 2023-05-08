import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/landing_page.dart';
import 'package:chat_app/pages/onBordingScreen.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'loginPage': (context) => LandingPage(),
        'registerPage': (context) => RegisterPage(),
        ChatPage.id:(context) => ChatPage(),
        'onBorading':(context) => onBoradingScreen(),
        'splashScreen':(context) => SplashScreen()
      },
      initialRoute: 'splashScreen',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
