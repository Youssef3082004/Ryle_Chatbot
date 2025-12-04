// import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';

// class UnityDemoScreen extends StatefulWidget {
//   const UnityDemoScreen({Key? key}) : super(key: key);

//   @override
//   _UnityDemoScreenState createState() => _UnityDemoScreenState();
// }

// class _UnityDemoScreenState extends State<UnityDemoScreen> {
//   UnityWidgetController? _unityWidgetController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Unity in Flutter')),
//       body: Card(
//         margin: const EdgeInsets.all(8),
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Stack(
//           children: [
//             UnityWidget(
//               onUnityCreated: _onUnityCreated,
//               // هذا يجعله ملء الشاشة أو بحجم الـ Card
//               fullscreen: false, 
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onUnityCreated(UnityWidgetController controller) {
//     _unityWidgetController = controller;
//   }
// }