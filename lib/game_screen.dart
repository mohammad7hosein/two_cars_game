import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late MyGame _myGame;

  @override
  void initState() {
    _myGame = MyGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        setState(() {
          _myGame.pauseGame();
        });
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GameWidget(game: _myGame),
              ValueListenableBuilder(
                valueListenable: _myGame.isGameOver,
                builder: (context, bool value, child) {
                  return value
                      ? Container(
                          color: Colors.black.withOpacity(0.7),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'GAME OVER!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'SCORE: ${_myGame.currentScore.value}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _myGame.restartGame();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.white,
                                    size: 120,
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (!_myGame.isGameOver.value) {
                                setState(() {
                                  _myGame.pauseGame();
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.pause_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _myGame.currentScore,
                            builder: (context, int value, child) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _myGame.resumeGame();
                            });
                          },
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
