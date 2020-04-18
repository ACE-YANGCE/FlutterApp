import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_wave.dart';

class ACEWavePage extends StatefulWidget {
  @override
  _ACEWavePageState createState() => new _ACEWavePageState();
}

class _ACEWavePageState extends State<ACEWavePage> {
  @override
  Widget build(BuildContext context) {
    List<double> waveWidth = [600, 800, 300];
    List<double> waveHeight = [60, 80, 70];
    List<double> startOffsetX = [30, 150, 100];
    List<double> startOffsetY = [100, 120, 100];
    List<Duration> duration = [
      Duration(milliseconds: 6000),
      Duration(milliseconds: 4000),
      Duration(milliseconds: 5000)
    ];
    List<List<Color>> colorList = [
      [Colors.green.withOpacity(0.2), Colors.white.withOpacity(0.4)],
      [Colors.blue.withOpacity(0.2), Colors.white.withOpacity(0.4)],
      [Colors.blue.withOpacity(0.2), Colors.white.withOpacity(0.4)]
    ];
    return Scaffold(
        appBar: AppBar(title: Text('ACEWave Page')),
        body: Container(
            color: Colors.grey,
            height: (MediaQuery.of(context).size.height),
            child: Container(
                child: ACEWave(
              waveWidth,
              waveHeight,
              300.0,
              startOffsetXList: startOffsetX,
              startOffsetYList: startOffsetY,
              durationList: duration,
              waveColorList: colorList,
            ))));
  }
}
