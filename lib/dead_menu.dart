import 'package:flutter/material.dart';
import 'package:mini_app/Auth/auth_controller.dart';
import 'package:mini_app/wolf_game.dart';

class GameOver extends StatelessWidget {
  // Reference to parent game.
  final WolfGame game;
  const GameOver({super.key, required this.game});

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
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                    const Text('RANKING',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: whiteTextColor,
                        )),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '1/247',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: whiteTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/score.png',
                            width: 30, fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        Text(
                          ': ${game.score}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: whiteTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ARDX.png',
                            width: 30, fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        Text(
                          ': ${game.score}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: whiteTextColor,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        game.overlays.remove('GameOver');
                        game.restart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF292A3B),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PLAY AGAIN',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: whiteTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
