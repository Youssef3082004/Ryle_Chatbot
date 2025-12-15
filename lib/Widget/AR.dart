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

      /* 2. Style the NEW Hint Message */
      .hint-box {
        position: absolute;
        top: 20px;            /* Position at top center */
        left: 50%;
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.6); /* Semi-transparent black */
        color: white;
        padding: 10px 20px;
        border-radius: 30px;
        font-family: sans-serif;
        font-size: 14px;
        pointer-events: none; /* Allows clicks to pass through to the model */
        transition: opacity 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
        z-index: 998;
        opacity: 1; /* Visible by default */
        /* vvvv ADD OR CHANGE THESE LINES vvvv */
        width: max-content;   /* Option A: Fits the text exactly (Default behavior) */
        /* width: 250px;      /* Option B: Fixed width */
        /* max-width: 80%;    /* Option C: Responsive (Good for mobile) */
        /* text-align: center; /* Centers text if width is fixed */
        /* justify-content: center; /* Centers content flex-wise */
      }
      
      /* Simple pulsing animation to catch attention */
      @keyframes pulse {
        0% { transform: translateX(-50%) scale(1); }
        50% { transform: translateX(-50%) scale(1.05); }
        100% { transform: translateX(-50%) scale(1); }
      }
      
      .hint-anim {
        animation: pulse 2s infinite;
      }

      /* Class to hide elements */
      .hidden {
        opacity: 0;
      }
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

      // 1. PLAY: Hide Hint, Show Stop Button
      modelViewer.addEventListener('click', () => {
        audio.play();
        modelViewer.play(); 
        
        stopBtn.classList.add('visible');      // Show Stop button
        hintMsg.classList.add('hidden');       // Hide Hint
      });

      // 2. STOP BUTTON: Show Hint, Hide Stop Button
      stopBtn.addEventListener('click', (event) => {
        event.stopPropagation(); 
        
        audio.pause();
        audio.currentTime = 0; 
        modelViewer.pause();
        modelViewer.currentTime = 0; 
        
        stopBtn.classList.remove('visible');   // Hide Stop button
        hintMsg.classList.remove('hidden');    // Show Hint again
      });

      // 3. AUTO-STOP: Show Hint, Hide Stop Button
      audio.addEventListener('ended', () => {
        modelViewer.pause();
        modelViewer.currentTime = 0; 
        
        stopBtn.classList.remove('visible');   // Hide Stop button
        hintMsg.classList.remove('hidden');    // Show Hint again
      });
    </script>
          """,
        ),
      );
  }
}