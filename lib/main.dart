import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/game/snake_game.dart';
import 'package:mini_app/utils/utils.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';

/// Global instance of GetIt
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'scaffoldMessenger');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure the application
  try {
    await configure();
  } catch (e) {
    print(e);
    return;
  }

  // Initialize the AuthController
  final authCtrl = AuthController();
  try {
    await authCtrl.loadUser();
  } catch (e) {
    print(e);
    return;
  }

  // Start the application
  runApp(
    ChangeNotifierProvider<AuthController>.value(
      value: authCtrl,
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Mini App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Center(
          child: Text('ss'),
        ),
      ),
    ),
  );
}
