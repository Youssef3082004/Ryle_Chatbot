import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';


class ArScreen extends StatelessWidget {
  final String Kingname;
  final String KingModelLink;
  final String SoundLink;
  const ArScreen({super.key, required this.Kingname, required this.KingModelLink,required this.SoundLink});

  @override
  Widget build(BuildContext context) {
  final Color _primaryColor = const Color(0xFF6D4C41); 
  final Color _backgroundColor = const Color(0xFFFBF0E9); 

    return Scaffold(
        appBar: AppBar(title: Text(Kingname,style: TextStyle(fontWeight: FontWeight.bold),),foregroundColor: Colors.white,centerTitle: true,backgroundColor: _primaryColor,),
        body: ModelViewer(
          backgroundColor: _backgroundColor,
          src: "${KingModelLink}?sound=${SoundLink}",
          autoPlay: false,          
          animationName: null,
          alt: 'A 3D model of an astronaut',
          ar: true,
          autoRotate: false,
          disableZoom: true,   
          innerModelViewerHtml: """   
    <style>
      .stop-btn {
        position: absolute;
        bottom: 20px;
        left: 20px;
        padding: 10px 20px;
        background-color: #6D4C41; 
        color: white;
        border: none;
        border-radius: 20px;
        font-family: sans-serif;
        font-weight: bold;
        cursor: pointer;
        opacity: 0; 
        transition: opacity 0.3s;
        z-index: 999;
        pointer-events: none;
      }
      
      .visible {
        opacity: 1; 
        pointer-events: auto;
      }
    </style>

    <audio id="kebab-sound" src=${SoundLink}></audio>

    <button id="stop-btn" class="stop-btn">Stop Voice</button>

    <script>
      const audio = document.getElementById('kebab-sound');
      const stopBtn = document.getElementById('stop-btn');
      const modelViewer = document.querySelector('model-viewer');

      // 1. PLAY: Start Audio AND Animation
      modelViewer.addEventListener('click', () => {
        // Play Audio
        audio.play();
        
        // Play Animation
        modelViewer.play(); 
        
        stopBtn.classList.add('visible');
      });

      // 2. STOP BUTTON: Pause Audio AND Animation
      stopBtn.addEventListener('click', (event) => {
        event.stopPropagation(); 
        
        // Stop Audio
        audio.pause();
        audio.currentTime = 0; 
        
        // Stop Animation (and reset to start if you want)
        modelViewer.pause();
        modelViewer.currentTime = 0; 
        
        stopBtn.classList.remove('visible');
      });

      // 3. AUTO-STOP: Audio Ends -> Animation Stops
      audio.addEventListener('ended', () => {
        modelViewer.pause();
        modelViewer.currentTime = 0; // Reset animation
        stopBtn.classList.remove('visible');
      });
    </script>
          """,
        ),
      );
  }
}