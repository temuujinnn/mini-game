import 'package:flutter/material.dart';
import 'package:mini_app/wolf_game.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final WolfGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            width: double.infinity,
            // height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3 + 40),
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                height: 250,
                width: 300,
                decoration: const BoxDecoration(
                  // color: blackTextColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        game.overlays.remove('MainMenu');
                        game.restart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF292A3B),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PLAY',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: whiteTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        game.overlays.add('MainMenu');
                        game.restart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF292A3B),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rank'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 30.0,
                              color: whiteTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
