import 'package:flutter/material.dart';
import 'package:mini_app/Auth/auth_controller.dart';
import 'package:mini_app/Auth/repository.dart';
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
                        game.overlays.add('Leaderboard');
                        try {
                          // final leaderboard = await fetchScoreboard();
                          // await leaderboardModal(context, leaderboard);
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
                          // authController.logout();
                          try {
                            await chargeGame();
                            _showSnackbar(context);
                          } catch (e) {}
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

  void _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      padding: EdgeInsets.all(0),
      content: Container(
        height: 100, // Set the desired height
        width: double.infinity, // Full width
        color: Colors.green, // Green background color
        alignment: Alignment.center,
        child: const Text(
          'Successfully Charged',
          style: TextStyle(color: Colors.white),
        ),
      ),
      behavior: SnackBarBehavior.fixed, // Display at the top
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
