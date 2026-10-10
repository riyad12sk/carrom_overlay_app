import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

void main() {
  runApp(const MyApp());
}

@pragma('vm:entry-point')
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarromOverlayWidget(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrom Overlay',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrom Pool Aim Assistant')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Carrom Assistant Ready!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final status = await FlutterOverlayWindow.isPermissionGranted();
                  if (!status) {
                    await FlutterOverlayWindow.requestPermission();
                  } else {
                    if (await FlutterOverlayWindow.isActive() == false) {
                      await FlutterOverlayWindow.showOverlay(
                        height: 400,
                        width: 400,
                        alignment: OverlayAlignment.center,
                        visibility: NotificationVisibility.visibilityPublic,
                        flag: OverlayFlag.defaultFlag,
                      );
                    }
                  }
                },
                child: const Text('Start Overlay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarromOverlayWidget extends StatelessWidget {
  const CarromOverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 3),
          borderRadius: BorderRadius.circular(15),
          color: Colors.black.withOpacity(0.2),
        ),
        child: const Center(
          child: Text(
            '🎯 Aim Line Active',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
