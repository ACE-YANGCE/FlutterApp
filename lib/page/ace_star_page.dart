import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/ace_star_painter.dart';

class ACEStarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEStarPageState();
}

class _ACEStarPageState extends State<ACEStarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('ACEStarWidget')),
            body: Center(
                child: PhysicalModel(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    clipBehavior: Clip.antiAlias,
                    elevation: 6.0,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Stack(children: [
                      Container(
                          width: 300,
                          height: 300,
                          child: Image.asset('images/icon_panda.jpeg')),
                      _flagWid()
                    ])))));
  }

  _flagWid() => ShaderMask(
      shaderCallback: (rect) => LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.white.withOpacity(0.0)],
            stops: [0.2, 0.8],
          ).createShader(rect),
      child: Container(
          width: 300,
          color: Color(0xFFDE2910),
          height: 300,
          child: CustomPaint(painter: ACEStarPainter())));
}
