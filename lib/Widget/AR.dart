import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:chatbot_app/Widget/AR_Sound.dart';


class ArScreen extends StatelessWidget {
  final String Kingname;
  final String KingModelLink;
  final String SoundLink;
  const ArScreen({super.key, required this.Kingname, required this.KingModelLink,required this.SoundLink});

  @override
  Widget build(BuildContext context) {
  final Color _primaryColor = const Color(0xFF6D4C41); 
  final Color _backgroundColor = const Color(0xFFFBF0E9); 
  
  IconButton ArButton = IconButton(onPressed: ()=>ARScreen.launchArIntent(KingModelLink: KingModelLink, SoundLink: SoundLink) , icon: Icon(Icons.view_in_ar,size: 30));

  AppBar ArAppbar = AppBar(actions: [ArButton],title: Text(Kingname,style: TextStyle(fontWeight: FontWeight.bold),),foregroundColor: Colors.white,centerTitle: true,backgroundColor: _primaryColor,);

    return Scaffold(appBar: ArAppbar,
        body: 
            ModelViewer(
              backgroundColor: _backgroundColor,
              src: "${KingModelLink}?sound=${SoundLink}",
              autoPlay: false,          
              animationName: null,
              alt: 'A 3D model of an astronaut',
              ar: false,
              autoRotate: false,
              disableZoom: true,   
              innerModelViewerHtml: """   
  <style>
      /* 1. Stop Button Style */
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
      
      .visible { opacity: 1; pointer-events: auto; }

      /* 2. Hint Box Style */
      .hint-box {
        position: absolute;
        top: 20px;
        left: 50%;
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.6);
        color: white;
        padding: 10px 20px;
        border-radius: 30px;
        font-family: sans-serif;
        font-size: 10px;
        pointer-events: none; 
        transition: opacity 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
        z-index: 998;
        opacity: 1;   
        max-width: 80%;    
        text-align: center;
        justify-content: center; 
      }
      
      /* 3. RESTORED: Pulse Animation */
      @keyframes pulse {
        0% { transform: translateX(-50%) scale(1); }
        50% { transform: translateX(-50%) scale(1.05); }
        100% { transform: translateX(-50%) scale(1); }
      }
      
      .hint-anim {
        animation: pulse 2s infinite;
      }
      
      .hidden { opacity: 0; }
    </style>

    <audio id="kebab-sound" src="${SoundLink}"></audio>

    <button id="stop-btn" class="stop-btn">Stop Voice</button>
    
    <div id="interaction-hint" class="hint-box hint-anim">
      Tap the model to hear what it says!
    </div>

    <script>
      const audio = document.getElementById('kebab-sound');
      const stopBtn = document.getElementById('stop-btn');
      const hintMsg = document.getElementById('interaction-hint');
      const modelViewer = document.querySelector('model-viewer');

      // Helper function to stop everything
      function stopEverything() {
        audio.pause();
        audio.currentTime = 0;
        modelViewer.pause();
        modelViewer.currentTime = 0;
        stopBtn.classList.remove('visible');
        hintMsg.classList.remove('hidden');
      }

      // 1. PLAY
      modelViewer.addEventListener('click', () => {
        audio.play();
        modelViewer.play(); 
        stopBtn.classList.add('visible');
        hintMsg.classList.add('hidden');
      });

      // 2. STOP BUTTON
      stopBtn.addEventListener('click', (event) => {
        event.stopPropagation(); 
        stopEverything();
      });

      // 3. AUTO-STOP (When song ends)
      audio.addEventListener('ended', () => {
        stopEverything();
      });

      // 4. AR FIX: Stop sound when leaving the app view
      document.addEventListener("visibilitychange", () => {
        if (document.hidden) {
           stopEverything();
        }
      });
      
    </script>
          """,
            ),
    

        );
      
  }
}