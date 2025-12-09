import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';


class ArScreen extends StatelessWidget {
  final String Kingname;
  final String KingModelLink;
  const ArScreen({super.key, required this.Kingname, required this.KingModelLink});

  @override
  Widget build(BuildContext context) {
  final Color _primaryColor = const Color(0xFF6D4C41); 
  final Color _backgroundColor = const Color(0xFFFBF0E9); 
    return Scaffold(
        appBar: AppBar(title: Text(Kingname,style: TextStyle(fontWeight: FontWeight.bold),),foregroundColor: Colors.white,centerTitle: true,backgroundColor: _primaryColor,),
        body: ModelViewer(
          backgroundColor: _backgroundColor,
          src: KingModelLink,
          autoPlay: true,          
          animationName: null,
          alt: 'A 3D model of an astronaut',
          ar: true,
          autoRotate: false,
          disableZoom: true,
        ),
      );
  }
}