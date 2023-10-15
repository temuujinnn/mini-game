import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_app/Auth/auth_controller.dart';
import 'package:mini_app/Auth/repository.dart';
import 'package:mini_app/wolf_game.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final WolfGame game;

  MainMenu({super.key, required this.game});
  final authController = Get.put(AuthController());
  final TextEditingController phoneNumberController =
      TextEditingController(text: '99110041');

  @override
  Widget build(BuildContext context) {
    // const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    authController.loadUser();
    print(authController.status);
    print(authController.phoneNumber);
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
                    Obx(
                      () => Text('${authController.phoneNumber.value}'),
                    ),
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
                    if (authController.status != AuthStatus.authenticated &&
                        authController.status == AuthStatus.loading)
                      ElevatedButton(
                        onPressed: () async {
                          authController.logout();
                          try {
                            // await chargeGame();
                            // _showSnackbar(context);
                            // sendScoreDPata(10033);
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

  Future<void> login(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        );
      },
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 400,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Welcome to ARDiin chono',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // SizedBox(height: 20),
          // Text(
          //   'Please enter your phone number',
          //   style: TextStyle(
          //     fontSize: 16,
          //   ),
          //   textAlign: TextAlign.start,
          // ),
          TextFormField(
            controller:
                phoneNumberController, // Assuming you have a TextEditingController
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final phoneNumber = phoneNumberController.text;
              await authController.loginPhoneNumber(phoneNumber);
              Navigator.of(context).pop(); // Close the dialog
              game.overlays.remove('MainMenu');
              game.restart();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF292A3B),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: <Widget>[
          //     TextButton(
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       },
          //       child: Text('Cancel'),
          //     ),
          // TextButton(
          //   onPressed: () async {
          //     final phoneNumber = phoneNumberController.text;
          //     if (phoneNumber.isNotEmpty) {
          //       AuthController authController = AuthController();

          //       try {
          //         await authController.loginPhoneNumber(phoneNumber);
          //         Navigator.of(context).pop(); // Close the dialog
          //         game.overlays.remove('MainMenu');
          //         game.restart();
          //       } catch (e) {
          //         print(e);
          //       }
          //     }
          //   },
          //   child: Text('Login'),
          // ),
          //   ],
          // ),
        ],
      ),
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
