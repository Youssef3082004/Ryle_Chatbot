import 'package:flutter/material.dart';
import 'welcome.dart';
import 'chat.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = 'AIzaSyDiZVuBtz08mZQx7hMWjEkARCTKTFAAd8Y';

void main() {
  Gemini.init(apiKey: apiKey, enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData Animiation = ThemeData(fontFamily:"AGaramondPro" ,pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android:FadeForwardsPageTransitionsBuilder(backgroundColor: Colors.transparent)}));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ryla Chatbot',
      theme: Animiation,

      initialRoute: '/',
      routes: {'/': (context) => const WelcomeScreen(),'/chat': (context) => const ChatScreen()},
    );
  }
}


