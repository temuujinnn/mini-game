import 'package:flutter/material.dart';
import 'package:mini_app/Auth/auth_controller.dart';
import 'package:mini_app/Auth/leaderboard_controller.dart';
import 'package:mini_app/wolf_game.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final WolfGame game;

  MainMenu({super.key, required this.game});
  final authController = AuthController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    authController.loadUser();
    print(authController.status);
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
                      onPressed: () async {
                        if (authController.status == AuthStatus.authenticated) {
                          game.overlays.remove('MainMenu');
                          game.restart();
                        } else {
                          login(context);
                        }
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
                      onPressed: () async {
                        try {
                          final leaderboard = await fetchScoreboard();
                          await LeaderboardModal(context, leaderboard);
                          // ignore: use_build_context_synchronouslyR
                          // await LeaderboardModal(context, leaderboard);
                        } catch (e) {
                          print(e);
                        }
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
                    const SizedBox(height: 20),
                    if (authController.status != AuthStatus.authenticated)
                      ElevatedButton(
                        onPressed: () async {
                          authController.logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF292A3B),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LOG OUT',
                              style: TextStyle(
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

  Future<void> login(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Please enter your phone number:'),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final phoneNumber = phoneNumberController.text;
                if (phoneNumber.isNotEmpty) {
                  AuthController authController = AuthController();
                  try {
                    await authController.loginPhoneNumber(phoneNumber);
                    Navigator.of(context).pop();
                    game.overlays.remove('MainMenu');
                    game.restart();
                  } catch (e) {
                    print(e);
                  }

                  // Navigator.of(context).pop();
                }
              },
              child: Text('Login'),
            ),
          ],
        );
      },
    );
  }

  Future<void> LeaderboardModal(context, leaderboard) async {
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0), // Remove padding
            content: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 70, bottom: 10),
                  width: 500,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/leaderboard_back.jpg'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: leaderboard.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 7),
                          // width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${index + 1}. ${leaderboard[index]!.data![index]!.playerName}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${leaderboard[index]!.data![index]!.score}',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'RANK',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: whiteTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
