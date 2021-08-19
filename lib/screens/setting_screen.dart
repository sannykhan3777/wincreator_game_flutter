import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Color color1 = Colors.white;
  Color color2 = Colors.grey;
  bool istrue1 = true;
  bool istrue2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  AudioPlayer player;
  AudioCache audioCache;

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
  }

  bool isSound = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: AssetImage("assets/Home.png"),
            ),
          ),
          child: Center(
            child: Container(
              height: height * 0.5,
              width: width * 0.5,
              child: Stack(
                alignment: Alignment.center,
                  children: [
                Container(
                  height: height * 0.5,
                  width: width * 0.5,
                  child: Image.asset(
                    'assets/alertbg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          audioCache.play("touch.mp3");
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              'assets/close.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: Text(
                        "SETTINGS".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontSize: 30.0,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              FlutterVolumeSlider(
                                display: Display.HORIZONTAL,
                                sliderActiveColor: Color(0xFF0A3BEC),
                                sliderInActiveColor: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20.0,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                istrue1 = true;
                                istrue2 = false;
                              });
                              audioCache.play("touch.mp3");
                              return context.locale = Locale('en', '');

                            },
                            child: Container(
                              height: height * 0.12,
                              width: width * 0.09,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xFF00a2ff),
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Color(0xFF00a2ff).withOpacity(istrue1 ? 1.0 : 0.5), BlendMode.dstATop),
                                  image: AssetImage('assets/english.png'),
                                ),
                              ),

                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                istrue2 = true;
                                istrue1 = false;
                              });
                              audioCache.play("touch.mp3");
                              return context.locale = Locale('ru', '');

                            },
                            child: Container(
                              height: height * 0.12,
                              width: width * 0.09,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xFF00a2ff),
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Color(0xFF00a2ff).withOpacity(istrue2 ? 1.0 : 0.5 ), BlendMode.dstATop),
                                  image: AssetImage('assets/russia.png'),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),

              ],),
            ),
          ),
        ),
      ),
    );
  }
}
