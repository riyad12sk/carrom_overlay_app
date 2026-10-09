import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

void main() => runApp(const AimAIApp());

@pragma("vm:entry-point")
void overlayMain() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: CarromOverlayScreen()));
}

class AimAIApp extends StatelessWidget {
  const AimAIApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const AimHome(),
    );
  }
}

class AimHome extends StatefulWidget {
  const AimHome({super.key});
  @override
  State<AimHome> createState() => _AimHomeState();
}

class _AimHomeState extends State<AimHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎯 AimAI Carrom Controller'), centerTitle: true),
      body: Center(
        child: FilledButton.icon(
          onPressed: () async {
            if (!await FlutterOverlayWindow.isPermissionGranted()) {
              await FlutterOverlayWindow.requestPermission();
            } else {
              await FlutterOverlayWindow.showOverlay(height: 500, width: 400);
            }
          },
          icon: const Icon(Icons.layers),
          label: const Text('START OVERLAY AIM'),
        ),
      ),
    );
  }
}

class CarromOverlayScreen extends StatefulWidget {
  const CarromOverlayScreen({super.key});
  @override
  State<CarromOverlayScreen> createState() => _CarromOverlayScreenState();
}

class _CarromOverlayScreenState extends State<CarromOverlayScreen> {
  Offset striker = const Offset(0.50, 0.84);
  final List<Offset> coins = [const Offset(0.50, 0.50), const Offset(0.45, 0.46)];
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: Colors.black87, border: Border.all(color: Colors.red, width: 2)),
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => FlutterOverlayWindow.closeOverlay(),
            ),
            const Expanded(
              child: Center(
                child: Text('Aim Overlay Active', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
