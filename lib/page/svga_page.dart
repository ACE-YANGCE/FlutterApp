import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class SVGAPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SVGAPageState();
}

class _SVGAPageState extends State<SVGAPage>
    with SingleTickerProviderStateMixin {
  SVGAAnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('SVGA Page')), body: _body02());
  }

  _body01() {
    return Column(children: [
      _itemSVGA01(false, 'images/posche.svga'),
      _itemSVGA01(true,
          'https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true')
    ]);
  }

  _itemSVGA01(isUrl, svgaUrl) {
    return Expanded(
        flex: 1,
        child: SVGASimpleImage(
            assetsName: isUrl ? null : svgaUrl,
            resUrl: isUrl ? svgaUrl : null));
  }

  @override
  void initState() {
    super.initState();
    this.animationController = SVGAAnimationController(vsync: this)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    this._loadAnimation();
  }

  @override
  void dispose() {
    this.animationController?.clear();
    this.animationController?.dispose();
    this.animationController = null;
    super.dispose();
  }

  void _loadAnimation() async {
    final videoItem = await _loadSVGA(false, 'images/posche.svga');
    if (mounted)
      setState(() {
        this.animationController?.videoItem = videoItem;
        this
            .animationController
            ?.addStatusListener((status) => print('---status---$status'));
      });
  }

  void _playAnimation() {
    if (animationController?.isCompleted == true) {
      animationController?.reset();
    }
    animationController?.repeat(); // or animationController.forward();
  }

  _body02() {
    return Column(children: <Widget>[
      Expanded(child: SVGAImage(this.animationController), flex: 1),
      Row(children: <Widget>[
        _itemBtn('start'),
        _itemBtn('stop'),
        _itemBtn('resume')
      ]),
      Row(children: <Widget>[
        _itemBtn('reverse'),
        _itemBtn('repeat'),
        _itemBtn('fling')
      ])
    ]);
  }

  Widget _itemBtn(str) => Expanded(
      child: Container(
          margin: EdgeInsets.all(1.0),
          child: FlatButton(
              color: Colors.lightBlueAccent,
              child: Text(str),
              onPressed: () {
                if (str == 'start') {
                  animationController?.reset();
                  animationController?.forward();
                } else if (str == 'reverse') {
                  animationController?.reverse();
                } else if (str == 'repeat') {
                  animationController?.repeat();
                } else if (str == 'resume') {
                  animationController?.forward();
                } else if (str == 'stop') {
                  animationController?.stop();
                } else if (str == 'fling') {
                  animationController?.fling();
                }
                setState(() {});
              })));

  Future _loadSVGA(isUrl, svgaUrl) {
    Future Function(String) decoder;
    if (isUrl) {
      decoder = SVGAParser.shared.decodeFromURL;
    } else {
      decoder = SVGAParser.shared.decodeFromAssets;
    }
    return decoder(svgaUrl);
  }
}
