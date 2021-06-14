import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/common_line_painter.dart';

class ImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text('Image Page')),
      body: _bodyWid01(),
    ));
  }

  _bodyWid01() {
    return ListView(children: <Widget>[
      Row(children: <Widget>[
        Expanded(child: _imageWid00(false)),
        SizedBox(width: 8),
        Expanded(child: _imageWid00(true))
      ]),
      SizedBox(height: 10.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid01(false)),
        SizedBox(width: 8),
        Expanded(child: _imageWid01(true))
      ]),
      SizedBox(height: 10.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid02(false)),
        SizedBox(width: 8),
        Expanded(child: _imageWid02(true))
      ]),
      SizedBox(height: 10.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid03(false)),
        SizedBox(width: 8),
        Expanded(child: _imageWid03(true))
      ]),
      SizedBox(height: 10.0),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        _imageWid05(80.0, 80.0),
        SizedBox(width: 8),
        _imageWid05(100.0, 100.0),
        SizedBox(width: 8),
        _imageWid05(120.0, 120.0)
      ]),
      SizedBox(height: 10.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid06(false, 0)),
        SizedBox(width: 8),
        Expanded(child: _imageWid06(true, 0)),
        SizedBox(width: 8),
        Expanded(child: _imageWid06(false, 1)),
        SizedBox(width: 8),
        Expanded(child: _imageWid06(true, 1))
      ]),
      SizedBox(height: 8.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid06(false, 2)),
        SizedBox(width: 8),
        Expanded(child: _imageWid06(true, 2)),
        SizedBox(width: 8),
        Expanded(child: _imageWid06(false, 3)),
        SizedBox(width: 8),
        Expanded(child: _imageWid06(true, 3))
      ]),
      SizedBox(height: 10.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid07(0)),
        SizedBox(width: 8),
        Expanded(child: _imageWid07(1)),
        SizedBox(width: 8),
        Expanded(child: _imageWid07(2)),
      ]),
      SizedBox(height: 10.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid08(0)),
        SizedBox(width: 8),
        Expanded(child: _imageWid08(1)),
        SizedBox(width: 8),
        Expanded(child: _imageWid08(2)),
      ]),
      SizedBox(height: 10.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid09(0)),
        SizedBox(width: 8),
        Expanded(child: _imageWid09(1)),
        SizedBox(width: 8),
        Expanded(child: _imageWid09(2)),
      ]),
      SizedBox(height: 8.0),
      Row(children: <Widget>[
        Expanded(child: _imageWid09(3)),
        SizedBox(width: 8),
        Expanded(child: _imageWid09(4)),
        SizedBox(width: 8),
        Expanded(child: _imageWid09(5)),
      ])
    ]);
  }

  _bodyWid02() {
    return Stack(children: [
      SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            // _imageWid11(),
            _imageWid10(0),
            _imageWid10(1),
            _imageWid10(2)
          ])),
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(painter: CommonLinePainter(context, 50.0)))
    ]);
  }

  _imageWid00(isNet) => Image(
      image: isNet
          ? NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')
          : AssetImage('images/icon_hzw01.jpg'));

  _imageWid01(isNet) {
    return Image(
        frameBuilder: (BuildContext context, Widget child, int frame,
            bool wasSynchronouslyLoaded) {
          return Container(
              padding: EdgeInsets.all(18.0),
              color: Colors.deepOrange.withOpacity(0.4),
              child: child);
        },
        image: isNet
            ? NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')
            : AssetImage('images/icon_hzw01.jpg'));
  }

  _imageWid02(isNet) {
    return Image(
        frameBuilder: (BuildContext context, Widget child, int frame,
            bool wasSynchronouslyLoaded) {
          return Container(
              padding: EdgeInsets.all(18.0),
              color: Colors.deepOrange.withOpacity(0.4),
              child: child);
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          return Container(
              padding: EdgeInsets.all(18.0),
              color: Colors.green.withOpacity(0.4),
              child: child);
        },
        image: isNet
            ? NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')
            : AssetImage('images/icon_hzw01.jpg'));
  }

  _imageWid03(isNet) {
    return Image(
        frameBuilder: (BuildContext context, Widget child, int frame,
            bool wasSynchronouslyLoaded) {
          return Container(
              padding: EdgeInsets.all(18.0),
              color: Colors.deepOrange.withOpacity(0.4),
              child: child);
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          return Container(
              padding: EdgeInsets.all(18.0),
              color: Colors.green.withOpacity(0.4),
              child: child);
        },
        errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return Container(
              height: 100.0,
              padding: EdgeInsets.all(18.0),
              color: Colors.grey.withOpacity(0.4),
              child: Center(child: Icon(Icons.error)));
        },
        image: isNet
            ? NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl11.jpg')
            : AssetImage('images/icon_hzw0111.jpg'));
  }

  _imageWid012() {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)),
        child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
            frameBuilder: (BuildContext context, Widget child, int frame,
                bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut);
        }));
  }

  _imageWid05(width, height) => Image(
      image: AssetImage('images/icon_hzw01.jpg'), width: width, height: height);

  _imageWid06(isNet, index) {
    BlendMode blendMode;
    if (index == 0) {
      blendMode = BlendMode.difference;
    } else if (index == 1) {
      blendMode = BlendMode.screen;
    } else if (index == 2) {
      blendMode = BlendMode.hardLight;
    } else {
      blendMode = BlendMode.colorBurn;
    }
    return Image(
        color: Colors.indigoAccent.withOpacity(0.4),
        colorBlendMode: blendMode,
        image: isNet
            ? NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')
            : AssetImage('images/icon_hzw01.jpg'));
  }

  _imageWid07(index) {
    Alignment alignment;
    if (index == 0) {
      alignment = Alignment.topLeft;
    } else if (index == 1) {
      alignment = Alignment.center;
    } else {
      alignment = Alignment.bottomRight;
    }
    return Image(
        image: AssetImage('images/icon_wechat_moments.png'),
        alignment: alignment,
        height: 120,
        frameBuilder: (BuildContext context, Widget child, int frame,
            bool wasSynchronouslyLoaded) {
          return Container(
              padding: EdgeInsets.all(2.0),
              color: Colors.deepOrange.withOpacity(0.4),
              child: child);
        });
  }

  _imageWid08(index) {
    ImageRepeat repeat;
    if (index == 0) {
      repeat = ImageRepeat.repeatX;
    } else if (index == 1) {
      repeat = ImageRepeat.repeatY;
    } else {
      repeat = ImageRepeat.repeat;
    }
    return Image(
        image: AssetImage('images/icon_wechat_moments.png'),
        repeat: repeat,
        height: 120,
        frameBuilder: (BuildContext context, Widget child, int frame,
            bool wasSynchronouslyLoaded) {
          return Container(
              padding: EdgeInsets.all(18.0),
              color: Colors.deepOrange.withOpacity(0.4),
              child: child);
        });
  }

  _imageWid09(index) {
    BoxFit fit;
    if (index == 0) {
      fit = BoxFit.fitWidth;
    } else if (index == 1) {
      fit = BoxFit.fitHeight;
    } else if (index == 2) {
      fit = BoxFit.fill;
    } else if (index == 3) {
      fit = BoxFit.cover;
    } else if (index == 4) {
      fit = BoxFit.contain;
    } else {
      fit = BoxFit.scaleDown;
    }
    return Image(
        image: AssetImage('images/icon_hzw03.jpg'),
        fit: fit,
        height: 120,
        frameBuilder: (BuildContext context, Widget child, int frame,
            bool wasSynchronouslyLoaded) {
          return Container(
              padding: EdgeInsets.all(2.0),
              color: Colors.deepOrange.withOpacity(0.4),
              child: child);
        });
  }

  _imageWid11() {
    return Image(
        fit: BoxFit.contain,
        // width: 250,
        // height: 250,
        image: AssetImage('images/icon_music.png'));
  }

  _imageWid10(index) {
    Rect rect;
    if (index == 0) {
      rect = null;
    } else if (index == 1) {
      rect = Rect.fromLTWH(100, 100, 50, 50);
    } else if (index == 2) {
      rect = Rect.fromLTWH(50, 50, 50, 50);
    }
    return Image(
        fit: BoxFit.contain,
        width: 250,
        height: 250,
        centerSlice: rect,
        image: AssetImage('images/icon_music.png'));
  }
}
