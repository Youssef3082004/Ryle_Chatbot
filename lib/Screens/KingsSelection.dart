import 'package:flutter/material.dart';
import "package:chatbot_app/Widget/AR.dart";



class King {
  final String name;
  final String imageName;
  final String ArModelLink;

  King({required this.name, required this.imageName, required this.ArModelLink});
}

final List<King> pharaohs = [
  King(name: "Narmer", imageName: "narmer.jpg", ArModelLink: "https://wsestolbnlfafbbhelee.supabase.co/storage/v1/object/public/3D/narmer.glb"),
  King(name: "Akhenaten", imageName: "Akhenaten.jpg", ArModelLink: "https://wsestolbnlfafbbhelee.supabase.co/storage/v1/object/public/3D/Aken_character_unity.glb"),
  King(name: "Ramesses II", imageName: "ram 11.jpg", ArModelLink: "https://wsestolbnlfafbbhelee.supabase.co/storage/v1/object/public/3D/Ramsses_Character.glb"),
  King(name: "Tutankhamun", imageName: "tutankhamun.jpeg", ArModelLink: "https://wsestolbnlfafbbhelee.supabase.co/storage/v1/object/public/3D/Tutankhamun.glb"),
  King(name: "Amenhotep III", imageName: "Amenhotep.jpg", ArModelLink: "https://wsestolbnlfafbbhelee.supabase.co/storage/v1/object/public/3D/Amenhotep.glb"),
  King(name: "Khufu", imageName: "Khufu.jpg", ArModelLink: "https://wsestolbnlfafbbhelee.supabase.co/storage/v1/object/public/3D/Khufu%20Char.glb"),
  King(name: "Cleopatra VII", imageName: "Cleopatra VII.jpg", ArModelLink: "https://wsestolbnlfafbbhelee.supabase.co/storage/v1/object/public/3D/Cleoptra%20mo.glb"),

];


class KingsSelectionScreen extends StatelessWidget {
  const KingsSelectionScreen({super.key});

  final Color _primaryColor = const Color(0xFF6D4C41);
  final Color _backgroundColor = const Color(0xFFFBF0E9); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor, 
        foregroundColor: Colors.white, 
        title: const Text(
          'Select a Pharaoh',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: pharaohs.length,
        itemBuilder: (context, index) {
          final king = pharaohs[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 4, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: _primaryColor.withOpacity(0.1),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/${king.imageName}',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  king.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: _primaryColor,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: _primaryColor.withOpacity(0.7),
                  size: 18,
                ),
                onTap: ()  => Navigator.push(context, MaterialPageRoute(builder: (context) => ArScreen(Kingname: king.name,KingModelLink: king.ArModelLink,) ))
                  
                  
                  
                ,
              ),
            ),
          );
        },
      ),
    );
  }
}