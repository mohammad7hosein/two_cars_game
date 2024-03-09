import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    theme: ThemeData.dark(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MyGame _myGame;

  @override
  void initState() {
    _myGame = MyGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: _myGame),
            ValueListenableBuilder(
              valueListenable: _myGame.isGameOver,
              builder: (context, bool value, child) {
                return value
                    ? Container(
                        color: Colors.black45,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'GAME OVER!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 140,
                                height: 140,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _myGame.restartGame();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    size: 140,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
            if (_myGame.isGamePlaying)
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _myGame.pauseGame();
                            });
                          },
                          icon: const Icon(Icons.pause_rounded),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _myGame.currentScore,
                          builder: (context, int value, child) {
                            return Text(
                              value.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (_myGame.isGamePaused)
              Container(
                color: Colors.black45,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'PAUSED!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _myGame.resumeGame();
                            });
                          },
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            size: 140,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
