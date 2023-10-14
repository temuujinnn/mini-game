import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'follow_camera.dart';

/// Global instance of GetIt
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'scaffoldMessenger');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Configure the application

  // Initialize the AuthController

  // Start the application
  runApp(
    MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Mini App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FollowComponentExample(
        viewportResolution: Vector2(500, 500),
      ),
    );
  }
}
