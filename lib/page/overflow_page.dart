import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/copyright_painter.dart';
import 'package:flutter_app/widget/ace_fold_textview.dart';

class OverflowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OverflowStatePage();
}

class OverflowStatePage extends State<OverflowPage> {
  String _paraStr = '      Flutter 是谷歌的移动UI框架，可以快速在 iOS 和 Android '
      '上构建高质量的原生用户界面。 Flutter 可以与现有的代码一起工作。在全世界，Flutter 正在被越来越多的开发者和组织使用，并且 Flutter '
      '是完全免费、开源的。';

  String _paraStr2 = 'Flutter 是谷歌的移动UI框架。';
  final textStyle = TextStyle(color: Colors.black, fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Overflow Page")),
        body: Stack(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(painter: CopyrightPainter())),
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250.0),
                Text('Flutter', style: TextStyle(fontSize: 24.0)),
                SizedBox(height: 20.0),
                Center(
                    child: ACEFoldTextView(_paraStr, textStyle,
                        maxWidth: MediaQuery.of(context).size.width - 100.0,
                        maxLines: 3))
              ])
        ]));
  }
}
