import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/common_line_painter.dart';
import 'package:flutter_app/canvas/paragraph_painter.dart';

class ParagraphPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParagraphPageState();
}

class _ParagraphPageState extends State<ParagraphPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Paragraph Page')),
            body: Stack(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                      CustomPaint(painter: CommonLinePainter(context, 50.0))),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CustomPaint(painter: ParagraphPainter())),
            ])));
  }
}
