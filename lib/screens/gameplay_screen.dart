import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wincreator/screens/end_screen.dart';

class GamePlayScreen extends StatefulWidget {
  @override
  _GamePlayScreenState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  AudioPlayer player;
  AudioCache audioCache;
  bool isTrue = false;
  int nmbr = 0;

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
  }

  Color color1 = Colors.white;
  Color color2 = Colors.grey;

  List<ItemModel> items;
  List<ItemModel> items2;
  List<ItemModel1> items3;
  List<ItemModel1> items4;

  int score;
  int scoree = 0;
  bool gameOver;

  Timer _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start <= 0) {
          setState(() {
            timer.cancel();
            audioCache.play("gameover.mp3");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EndScreen(
                  scoree: score,
                ),
              ),
            );
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initGame();
    startTimer();
    initPlayer();
  }

  initGame() {
    gameOver = false;
    score = 0 + scoree;
    items = [
      ItemModel(
          image: Image.asset("assets/ball_02.png"),
          name: "volleyball",
          value: "hand"),
      ItemModel(
          image: Image.asset("assets/cuttedball.png"),
          name: "football",
          value: "shoe"),
      ItemModel(
          image: Image.asset("assets/ballcloth.png"),
          name: "ball",
          value: "racket"),
    ];

    items2 = [
      ItemModel(
          image: Image.asset("assets/cutter.png"),
          name: "ball",
          value: "racket"),
      ItemModel(
          image: Image.asset("assets/thread.png"),
          name: "football",
          value: "shoe"),
      ItemModel(
          image: Image.asset("assets/pumper.png"),
          name: "volleyball",
          value: "hand"),
    ];
    items3 = [
      ItemModel1(
          image: Image.asset("assets/ball_fresh.png"),
          name: "ball",
          value: "racket"),
    ];
    items4 = [
      ItemModel1(
          image: Image.asset("assets/jala.png"), name: "ball", value: "racket"),
    ];
    // items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (_start <= 0) {
      gameOver = true;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Game_screen.png"),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: 70,
                    top: 25.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/scoretimer.png',
                              //width: 150,
                            ),
                            Text(
                              "$_start",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  letterSpacing: 1.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/scoretimer.png',
                              //width: 150,
                            ),
                            Text(
                              "$score",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  letterSpacing: 1.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!gameOver)
                    Positioned(
                      top: 200.0,
                      left: 30,
                      child: Stack(
                          children: items.map((item) {
                        return Draggable<ItemModel>(
                          data: item,
                          childWhenDragging: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: item.image,
                          ),
                          feedback: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: item.image,
                            ),
                            width: 80.0,
                            height: 80.0,
                            color: Color(0xFFECD823).withOpacity(0.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF5acc5a),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: item.image),
                          ),
                        );
                      }).toList()),
                    ),
                  isTrue
                      ? Positioned(
                          left: 150,
                          top: 220,
                          child: Column(
                            children: [
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: items3.map((item) {
                                    return Draggable<ItemModel1>(
                                      data: item,
                                      childWhenDragging: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: item.image,
                                      ),
                                      feedback: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: item.image,
                                        ),
                                        width: 80.0,
                                        height: 80.0,
                                        color:
                                            Color(0xFFECD823).withOpacity(0.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: item.image,
                                      ),
                                      onDragCompleted: () {
                                        if (nmbr >= 3) {
                                          setState(() {
                                            nmbr = 0;
                                            initGame();
                                          });
                                        }
                                      },
                                    );
                                  }).toList()),
                            ],
                          ),
                        )
                      : Positioned(
                          top: 150.0,
                          left: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: items2.map((item) {
                              return DragTarget<ItemModel>(
                                onAccept: (receivedItem) {
                                  if (item.value == receivedItem.value) {
                                    setState(() {
                                      nmbr++;
                                      if (nmbr == 3) {
                                        setState(() {
                                          isTrue = !isTrue;
                                        });
                                      }
                                      items.remove(receivedItem);
                                      items2.remove(item);
                                      item.accepting = false;
                                    });
                                  } else {
                                    setState(() {
                                      _start -= 2;
                                      item.accepting = false;
                                    });
                                  }
                                },
                                onLeave: (receivedItem) {
                                  setState(() {
                                    item.accepting = false;
                                  });
                                },
                                onWillAccept: (receivedItem) {
                                  setState(() {
                                    item.accepting = true;
                                  });
                                  return true;
                                },
                                builder:
                                    (context, acceptedItems, rejectedItem) =>
                                        Container(
                                  color: item.accepting
                                      ? Colors.red.withOpacity(0.0)
                                      : Color(0xFF9B9E0C).withOpacity(0.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: item.image,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                  Positioned(
                    right: 0.0,
                    bottom: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: items4.map((item) {
                        return DragTarget<ItemModel1>(
                          onAccept: (receivedItem) {
                            if (item.value == receivedItem.value) {
                              setState(() {
                                isTrue = false;
                                score += 1;
                                scoree = score;
                                audioCache.play("score.mp3");
                                // _start += 2;
                                item.accepting = false;
                              });
                            } else {
                              setState(() {
                                _start -= 2;
                                item.accepting = false;
                              });
                            }
                          },
                          onLeave: (receivedItem) {
                            setState(() {
                              item.accepting = false;
                            });
                          },
                          onWillAccept: (receivedItem) {
                            setState(() {
                              item.accepting = true;
                            });
                            return true;
                          },
                          builder: (context, acceptedItems, rejectedItem) =>
                              Container(
                            color: item.accepting
                                ? Colors.red.withOpacity(0.0)
                                : Color(0xFF9B9E0C).withOpacity(0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: item.image,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 10.0,
              child: GestureDetector(
                onTap: () {
                  audioCache.play("touch.mp3");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EndScreen(
                        scoree: score,
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/back.png",
                      // // width: 140,
                      height: 70,
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

class ItemModel {
  final String name;
  final String value;
  final Image image;
  final IconData icon;
  bool accepting;

  ItemModel(
      {this.name, this.value, this.image, this.icon, this.accepting = false});
}

class ItemModel1 {
  final String value;
  final String name;
  final Image image;
  final IconData icon;
  bool accepting;

  ItemModel1(
      {this.name, this.value, this.image, this.icon, this.accepting = false});
}
