import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ARScreen {
  
  

  static Future<void> launchArIntent({required String KingModelLink,required String SoundLink}) async {
      if (Platform.isAndroid) {
        final encodedModel = Uri.encodeComponent(KingModelLink);
        final encodedAudio = Uri.encodeComponent(SoundLink);
        final sceneViewerUrl =
            'https://arvr.google.com/scene-viewer/1.0'
            '?file=$encodedModel'
            '&sound=$encodedAudio'
            '&mode=ar_only'; 

        final uri = Uri.parse(sceneViewerUrl);

        try {

          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } catch (e) {
          debugPrint("Could not launch AR: $e");
        }
      } 
    }
    
}