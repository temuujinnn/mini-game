import 'package:flutter/material.dart';
import 'package:mini_app/models/leaderboard_model.dart';
import 'package:mini_app/wolf_game.dart';
import 'package:mini_app/Auth/repository.dart';

class LeaderBoard extends StatefulWidget {
  final WolfGame game;

  const LeaderBoard({super.key, required this.game});
  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<LeaderBoardModel> leaderboard = [];

  @override
  void initState() {
    super.initState();

    fetchScoreboard().then((leaderboard) {
      setState(() {
        this.leaderboard = leaderboard;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    return Scaffold(
      body: Stack(
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 90, vertical: 7),
                    // width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${index + 1}. ${leaderboard[index].data![index].playerName}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          '${leaderboard[index].data![index].score}',
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
                      widget.game.overlays.remove('Leaderboard');
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
