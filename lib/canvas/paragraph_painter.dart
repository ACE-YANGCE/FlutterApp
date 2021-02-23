import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ParagraphPainter extends CustomPainter {
  String _paraStr = 'Flutter 是谷歌的移动UI框架，可以快速在 iOS 和 Android 上构建高质量的原生用户界面。 '
      'Flutter 可以与现有的代码一起工作。在全世界，Flutter 正在被越来越多的开发者和组织使用，并且 Flutter '
      '是完全免费、开源的。';
  String _paraStr2 = 'Flutter 是谷歌的移动UI框架，可以快速在 iOS 和 Android 上构建高质量的原生用户界面。';
  double _spaceHeight = 0.0;

  String _paraStr3 = 'Hello Flutter 阿策小和尚！';
  Paint _paint = Paint()
    ..color = Colors.red
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;
  var _gradient, _bgGradient;
  var _shadow = [
    Shadow(offset: Offset(2.0, 2.0), blurRadius: 4.0, color: Colors.grey)
  ];

  @override
  void paint(Canvas canvas, Size size) {
    _gradient = ui.Gradient.linear(
        Offset(0.0, 0.0),
        Offset(0.0, size.height),
        [Colors.orange, Colors.deepOrange, Colors.green],
        [0 / 3, 1 / 3, 2 / 3]);
    _bgGradient = ui.Gradient.linear(Offset(0.0, 0.0), Offset(0.0, size.height),
        [Colors.blueGrey, Colors.white, Colors.grey], [0 / 3, 1 / 3, 2 / 3]);
    // _paragraph01(_paraStr3, canvas, size);
    // _paragraph02(_paraStr3, canvas, size);
    _paragraph03(_paraStr, canvas, size);
    // _paragraph04(_paraStr, canvas, size);
    // _paragraph05(_paraStr, canvas, size);
    // _paragraph06(_paraStr3, canvas, size);
    // _paragraph07(_paraStr, canvas, size);
    _paragraph08(_paraStr, canvas, size);
    // _paragraph09(_paraStr, canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _paragraph01(str, canvas, size) {
    for (int i = 0; i < 6; i++) {
      ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
          // textAlign: TextAlign.right,
          // textDirection: TextDirection.ltr,
          fontWeight: FontWeight.values[i + 1],
          fontStyle: (i % 2 == 0) ? FontStyle.normal : FontStyle.italic,
          fontFamily: 'DancingScript',
          // fontStyle: FontStyle.normal,
          // fontFamily: 'DancingScript',
          // height: 10,
          // maxLines: 1,
          // ellipsis: '...',
          fontSize: 14.0 + (i + 1)))
        ..pushStyle(ui.TextStyle(color: Colors.blue))
        ..addText(str);
      ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
      Paragraph paragraph = _pb.build()..layout(pc);
      canvas.drawParagraph(paragraph, Offset(50.0, 50.0 * (i + 1)));
    }
    canvas.drawRect(
        Rect.fromPoints(Offset(49.0, 49.0), Offset(size.width - 49, 350.0)),
        _paint);
  }

  _paragraph02(str, canvas, size) {
    for (int i = 0; i < 6; i++) {
      ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
          // textAlign: TextAlign.right,
          // textDirection: TextDirection.ltr,
          fontWeight: FontWeight.values[i + 1],
          fontStyle: (i % 2 == 0) ? FontStyle.normal : FontStyle.italic,
          fontFamily: 'DancingScript',
          // height: 10,
          // maxLines: 1,
          // ellipsis: '...',
          fontSize: 14.0 + (i + 1)))
        ..pushStyle(ui.TextStyle(color: Colors.blue))
        ..addText(str);
      ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
      Paragraph paragraph = _pb.build()..layout(pc);
      canvas.drawParagraph(paragraph, Offset(50.0, 50.0 * (i + 1)));
    }
    canvas.drawRect(
        Rect.fromPoints(Offset(49.0, 49.0), Offset(size.width - 49, 350.0)),
        _paint);
  }

  _paragraph03(str, canvas, size) {
    Paragraph paragraph;
    ParagraphBuilder _pb = ParagraphBuilder(
        ParagraphStyle(fontWeight: FontWeight.normal, fontSize: 17))
      ..pushStyle(ui.TextStyle(color: Colors.blue))
      ..addText(str);
    ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
    paragraph = _pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(50.0, 50.0));
    canvas.drawRect(
        Rect.fromPoints(
            Offset(49.0, 49.0), Offset(size.width - 49, paragraph.height + 50)),
        _paint);
    _spaceHeight = paragraph.height + 50.0;
  }

  _paragraph04(str, canvas, size) {
    Paragraph paragraph;
    ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
        fontWeight: FontWeight.normal, maxLines: 2, fontSize: 17))
      ..pushStyle(ui.TextStyle(color: Colors.blue))
      ..addText(str);
    ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
    paragraph = _pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(50.0, 50.0 + _spaceHeight));
    canvas.drawRect(
        Rect.fromPoints(Offset(49.0, 49.0 + _spaceHeight),
            Offset(size.width - 49, paragraph.height + 50 + _spaceHeight)),
        _paint);
    _spaceHeight += paragraph.height + 50.0;
  }

  _paragraph05(str, canvas, size) {
    Paragraph paragraph;
    ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
        fontWeight: FontWeight.normal,
        maxLines: 4,
        ellipsis: '...',
        fontSize: 17))
      ..pushStyle(ui.TextStyle(color: Colors.blue))
      ..addText(str);
    ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
    paragraph = _pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(50.0, 50.0 + _spaceHeight));
    canvas.drawRect(
        Rect.fromPoints(Offset(49.0, 49.0 + _spaceHeight),
            Offset(size.width - 49, paragraph.height + 50 + _spaceHeight)),
        _paint);
  }

  _paragraph06(str, canvas, size) {
    for (int i = 0; i < 12; i++) {
      ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
          textAlign: _paragraphTextAlign(i),
          textDirection: (i % 2 == 0) ? TextDirection.ltr : TextDirection.rtl,
          fontSize: 17))
        ..pushStyle(ui.TextStyle(color: Colors.blue))
        ..addText(str);
      ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
      Paragraph paragraph = _pb.build()..layout(pc);
      canvas.drawParagraph(
          paragraph, Offset(50.0, i * paragraph.height + 20 * (i + 1)));
      if (i % 2 == 0) {
        canvas.drawRect(
            Rect.fromPoints(Offset(49.0, 20.0),
                Offset(size.width - 49, i * paragraph.height + 20 * (i + 1))),
            _paint);
      }
    }
  }

  _paragraph07(str, canvas, size) {
    ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
      height: 2,
      fontSize: 17,
      strutStyle:
          ui.StrutStyle(fontFamily: 'DancingScript', fontSize: 20, height: 2),
    ))
      ..pushStyle(ui.TextStyle(color: Colors.blue))
      ..addText(str);
    ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
    Paragraph paragraph = _pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(50.0, 50 + _spaceHeight));
    canvas.drawRect(
        Rect.fromPoints(Offset(49.0, 50.0 + _spaceHeight),
            Offset(size.width - 49, 50.0 + paragraph.height + _spaceHeight)),
        _paint);
  }

  _paragraph08(str, canvas, size) {
    ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(fontSize: 17))
      ..pushStyle(ui.TextStyle(
          // color: Colors.green,
          foreground: Paint()..shader = _gradient,
          // background: Paint()..shader = _bgGradient,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          wordSpacing: 4,
          letterSpacing: 2,
          shadows: _shadow))
      ..addText(str);
    ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
    Paragraph paragraph = _pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(50.0, 50 + _spaceHeight));
    canvas.drawRect(
        Rect.fromPoints(Offset(49.0, 50.0 + _spaceHeight),
            Offset(size.width - 49, 50.0 + paragraph.height + _spaceHeight)),
        _paint..shader = _gradient);
  }

  _paragraph09(str, canvas, size) {
    for (int i = 0; i < 3; i++) {
      ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(fontSize: 18))
        ..pushStyle(ui.TextStyle(
            foreground: Paint()..shader = _gradient,
            fontWeight: FontWeight.w700,
            wordSpacing: 4));
      if (i == 0) {
        _pb = _pb
          ..addPlaceholder(
              60,
              60,
              i <= 1
                  ? PlaceholderAlignment.bottom
                  : PlaceholderAlignment.middle);
        _pb = _pb..addText(str);
      } else {
        _pb = _pb..addText(str);
        _pb = _pb
          ..addPlaceholder(
              60,
              60,
              i <= 1
                  ? PlaceholderAlignment.bottom
                  : PlaceholderAlignment.middle);
      }
      ParagraphConstraints pc = ParagraphConstraints(width: size.width - 100);
      Paragraph paragraph = _pb.build()..layout(pc);
      canvas.drawParagraph(paragraph, Offset(50.0, 50 + _spaceHeight));
      canvas.drawRect(
          Rect.fromPoints(Offset(49.0, 50.0 + _spaceHeight),
              Offset(size.width - 49, 50.0 + paragraph.height + _spaceHeight)),
          _paint..shader = _gradient);
      _spaceHeight += paragraph.height;
    }
  }

  _paragraphTextAlign(i) {
    TextAlign _textAlign;
    if (i == 0 || i == 1) {
      _textAlign = TextAlign.center;
    } else if (i == 2 || i == 3) {
      _textAlign = TextAlign.left;
    } else if (i == 4 || i == 5) {
      _textAlign = TextAlign.right;
    } else if (i == 6 || i == 7) {
      _textAlign = TextAlign.justify;
    } else if (i == 8 || i == 9) {
      _textAlign = TextAlign.start;
    } else if (i == 10 || i == 11) {
      _textAlign = TextAlign.end;
    }
    return _textAlign;
  }
}

class ACETextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(color: Colors.black, fontSize: 26);
    final textSpan = TextSpan(text: 'Hello Flutter 阿策小和尚', style: textStyle);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width - 100);
    final offset = Offset(50, 50);
    textPainter.paint(canvas, offset);

    TextPainter(
        text: TextSpan(
            text: '多种样式，如：',
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: '红色',
                  style: TextStyle(fontSize: 18.0, color: Colors.red)),
              TextSpan(
                  text: '绿色',
                  style: TextStyle(fontSize: 18.0, color: Colors.green)),
              TextSpan(
                  text: '蓝色',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue)),
              TextSpan(
                  text: '白色',
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
              TextSpan(
                  text: '\n紫色',
                  style: TextStyle(fontSize: 18.0, color: Colors.purple)),
              TextSpan(
                  text: '黑色',
                  style: TextStyle(fontSize: 18.0, color: Colors.black))
            ]),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(minWidth: 0, maxWidth: size.width - 100)
      ..paint(canvas, Offset(50.0, 150.0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
