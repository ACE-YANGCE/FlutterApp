import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ACEFoldTextView extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle textStyle;
  final double maxWidth;
  final Color moreBgColor;

  const ACEFoldTextView(this.text, this.textStyle,
      {this.maxLines, this.maxWidth, this.moreBgColor});

  @override
  _ACEFoldTextViewState createState() => _ACEFoldTextViewState();
}

const _kMoreWidth = 70.0;

class _ACEFoldTextViewState extends State<ACEFoldTextView> {
  bool _isOverFlow = false;
  Color _bgColor = Colors.white;
  String _textStr = '';
  var _maxLines, _temLines;
  List<ui.LineMetrics> _lines;

  @override
  void initState() {
    super.initState();
    _bgColor = widget.moreBgColor ?? Colors.white;
    _textStr = widget.text;
    _maxLines = widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      _isOverFlow = _checkOverMaxLines01(_maxLines, widget.maxWidth);
      _temLines = _checkOverMaxLines02(widget.maxWidth)?.length;
      return (_temLines < _maxLines)
          ? _itemText()
          : Stack(children: <Widget>[_itemText(), _moreText()]);
    });
  }

  _itemText() => Container(
      width: widget.maxWidth,
      child: Text(_textStr,
          style: widget.textStyle,
          maxLines: _maxLines,
          overflow: TextOverflow.visible));

  _moreText() => Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
          child: _transparentWid01(),
          onTap: () => setState(() {
                if (_temLines > _maxLines) {
                  if (_lines.last.width + _kMoreWidth >= widget.maxWidth) {
                    _maxLines = _temLines + 1;
                    _textStr = '${widget.text}\n';
                  } else {
                    _maxLines = _temLines;
                  }
                } else if (_temLines == _maxLines) {
                  _maxLines = widget.maxLines;
                }
              })));

  _transparentWid01() => Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [_bgColor.withOpacity(0.0), _bgColor],
              end: FractionalOffset(0.5, 0.5))),
      width: _kMoreWidth,
      child: Text((_temLines > _maxLines) ? '展开' : '收起',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: widget.textStyle?.fontSize ?? 14.0)));

  _transparentWid02() => ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
            colors: [_bgColor.withOpacity(0.0), _bgColor],
          ).createShader(bounds),
      child: Container(
          alignment: Alignment.centerRight,
          color: Colors.white,
          width: _kMoreWidth,
          child: Text((_temLines > _maxLines) ? '展开' : '收起',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: widget.textStyle?.fontSize ?? 14.0))));

  _checkOverMaxLines01(maxLines, maxWidth) {
    final textSpan = TextSpan(text: _textStr, style: widget.textStyle);
    final textPainter = TextPainter(
        text: textSpan, textDirection: TextDirection.ltr, maxLines: maxLines);
    textPainter.layout(
        maxWidth: widget.maxWidth ?? MediaQuery.of(context).size.width);
    return textPainter.didExceedMaxLines;
  }

  _checkOverMaxLines02(maxWidth) {
    final textSpan = TextSpan(text: _textStr, style: widget.textStyle);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(
        maxWidth: widget.maxWidth ?? MediaQuery.of(context).size.width);
    _lines = textPainter.computeLineMetrics();
    return _lines;
  }
}
