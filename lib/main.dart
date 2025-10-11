import 'package:flutter/material.dart';
import 'welcome.dart';
import 'chat.dart';
// import 'chat.dart';

void main() {
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
      routes: {'/': (context) => const WelcomeScreen(),'/chat': (context) => const ChatScreen2()},
    );
  }
}



