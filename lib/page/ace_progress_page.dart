import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/ace_progress_painter.dart';
import 'package:flutter_app/canvas/common_line_painter.dart';

class ACEProgressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEProgressPageState();
}

class _ACEProgressPageState extends State<ACEProgressPage> {
  String _string = 'Flutter 是谷歌的移动 UI 框架，可以快速在 iOS 和 Android 上构建高质量的原生用户界面';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('ACEProgress Page')),
            body: Stack(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                      CustomPaint(painter: CommonLinePainter(context, 50.0))),
              ListView(children: <Widget>[
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(painter: ACEProgressPainter(0.5))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.03,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8),
                            isFill: true))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.3,
                            spaceWidth: 40.0,
                            leftText: '收入',
                            rightText: '支出',
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8),
                            isFill: true))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.93,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8),
                            isFill: true))),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.03,
                            strokeWidth: 4.0,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8)))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.3,
                            strokeWidth: 8.0,
                            spaceWidth: 40.0,
                            leftText: '收入',
                            rightText: '支出',
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8)))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.93,
                            strokeWidth: 12.0,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8)))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.03,
                            leftText: _string,
                            rightText: _string,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8),
                            isFill: true))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.3,
                            spaceWidth: 40.0,
                            leftText: _string,
                            rightText: _string,
                            leftTextColor: Colors.red,
                            rightTextColor: Colors.blue,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8),
                            isFill: true))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.93,
                            spaceWidth: 40.0,
                            leftText: _string,
                            rightText: _string,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8),
                            isFill: true))),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    child: CustomPaint(
                        painter: ACEProgressPainter(0.5,
                            strokeWidth: 8.0,
                            leftText: _string,
                            rightText: _string,
                            leftTextColor: Colors.red,
                            rightTextColor: Colors.blue,
                            leftColor: Colors.teal.withOpacity(0.8),
                            rightColor: Colors.orange.withOpacity(0.8))))
              ])
            ])));
  }
}
