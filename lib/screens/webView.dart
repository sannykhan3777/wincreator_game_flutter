import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wincreator/screens/home_screen.dart';
class webView extends StatefulWidget {
  const webView({Key key}) : super(key: key);

  @override
  _webViewState createState() => _webViewState();
}

class _webViewState extends State<webView> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  AudioCache audioCache;
  AudioPlayer player;

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            audioCache.play("touch.mp3");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SafeArea(
          child: WebView(
        // initialUrl:
        //     'http://www.madehow.com/Volume-5/Soccer-Ball.html#:~:text=The%20standard%20soccer%20ball%20is,Modern%20balls%20have%20a%20valve',
        // javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'http://www.madehow.com/Volume-5/Soccer-Ball.html',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
      )),
    );
  }
}
