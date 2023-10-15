import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:mini_app/component/leaderboard.dart';

import 'dead_menu.dart';
import 'main_menu.dart';
import 'wolf_game.dart';

/// Global instance of GetIt
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'scaffoldMessenger');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
    return GameWidget.controlled(
      gameFactory: () => WolfGame(
        // phone default size is 360x640
        viewportResolution: Vector2(1080, 1920),
      ),
      overlayBuilderMap: {
        'MainMenu': (_, WolfGame game) => MainMenu(game: game),
        'GameOver': (_, WolfGame game) => GameOver(game: game),
        'Leaderboard': (_, WolfGame game) => LeaderBoard(game: game),
      },
      initialActiveOverlays: const ['MainMenu'],
      loadingBuilder: (_) => const Center(
        child: Text('Loading'),
      ),
    );
  }
}
