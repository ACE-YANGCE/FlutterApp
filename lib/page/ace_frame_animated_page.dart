import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_frame_animated.dart';

class ACEFrameAnimatedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEFrameAnimatedState();
}

class _ACEFrameAnimatedState extends State<ACEFrameAnimatedPage> {
  List<Map<ACEFramePicType, String>> picList = [
    Map.from({ACEFramePicType.asset: 'images/icon_hzw01.jpg'}),
    Map.from({ACEFramePicType.asset: 'images/icon_hzw02.jpg'}),
    Map.from({ACEFramePicType.asset: 'images/icon_hzw03.jpg'}),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('ACEFrameAnimated Page')),
            body: Center(
                child: Container(
              width: 150,
              height: 150,
              child: ACEFrameAnimated(picList, Duration(milliseconds: 800)),
            ))));
  }
}
