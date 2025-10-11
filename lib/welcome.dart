import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //! ============================================= Outlined Button ===========================================
    Text Button_label = const Text('Start Talking to Ryla >>',style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 129, 69, 69),fontWeight: FontWeight.w600,fontFamily: 'AGaramondPro'));
    ButtonStyle buttonStyle = OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white, width: 2),backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15));
    OutlinedButton button = OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/chat'),style: buttonStyle,child: Button_label);


    //! ============================================= main Application ===========================================
    Column Controls = Column(children: [SizedBox(height: 720),button],mainAxisAlignment: MainAxisAlignment.center);
    BoxDecoration decoration = const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/final.png'),fit: BoxFit.fill));
    Container main_app = Container(decoration: decoration,child: Controls,alignment:Alignment.center); 
    return Scaffold(body: main_app,); 

  }
}