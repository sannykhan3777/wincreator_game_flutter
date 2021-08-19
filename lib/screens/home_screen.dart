import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wincreator/screens/gameplay_screen.dart';
import 'package:wincreator/screens/setting_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wincreator/screens/webView.dart';

class HomeScreen extends StatefulWidget {
  final int scoreee;

  HomeScreen({Key key, this.scoreee}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int top1;

  setScore() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int score_1 = _pref.getInt('score_1') ?? 0; // 50

    if (widget.scoreee > score_1) {
      _pref.setInt('score_1', (widget.scoreee));
    }
  }

  getScore() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int score_1 = _pref.getInt('score_1') ?? 0; // 50
    setState(() {
      top1 = score_1;
    });

    print(top1);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initPlayer();
    setScore();
    getScore();
  }

  AudioPlayer player;
  AudioCache audioCache;

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.fromLTRB(45.0, 50.0, 45.0, 0.0),
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Home.png"), fit: BoxFit.cover),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BEST SCORE".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 45.0,
                          color: Color(0xFFFFFFFF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                Positioned(
                    top: 60,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/ball_1.png',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '$top1',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ],
                    )),
                Positioned(
                  top: 110.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          audioCache.play("touch.mp3");
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => GamePlayScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/button.png",
                              width: 190,
                              height: 100.0,
                            ),
                            Text(
                              "play".tr(),
                              style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 175.0,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          audioCache.play("touch.mp3");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/button.png",
                              width: 190,
                              height: 100.0,
                            ),
                            Text(
                              "SETTINGS".tr(),
                              style: TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 255.0,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          audioCache.play("touch.mp3");
                          // _launchInWebViewOrVC(url : url);
                          // // _launchInBrowser(url: url);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => webView()));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/button.png",
                              width: 190,
                              height: 70.0,
                            ),
                            Text(
                              "CREATE BALL".tr(),
                              style: TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
