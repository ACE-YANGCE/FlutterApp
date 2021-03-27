import 'package:flutter/material.dart';

class ACEFrameAnimated extends StatefulWidget {
  final List<Map<ACEFramePicType, String>> picList;
  final Duration duration;

  ACEFrameAnimated(this.picList, this.duration);

  @override
  State<StatefulWidget> createState() =>
      _ACEFrameAnimatedState(picList, duration);
}

class _ACEFrameAnimatedState extends State<ACEFrameAnimated> {
  List<Map<ACEFramePicType, String>> _picList;
  Duration _duration;
  int _index = 0;
  Widget _buildWid = Container();

  _ACEFrameAnimatedState(this._picList, this._duration);

  @override
  void initState() {
    super.initState();
    _framePicList();
  }

  @override
  void dispose() {
    super.dispose();
    if (_picList != null) {
      _picList.clear();
    }
    if (widget != null && widget.picList != null) {
      widget.picList.clear();
    }
  }

  @override
  Widget build(BuildContext context) => _buildWid;

  _framePicList() async {
    setState(() {
      _index = _index % _picList.length;
      _buildWid = Container(
          child: _picList[_index].keys.toList()[0] == ACEFramePicType.asset
              ? Image.asset(_picList[_index].values.toList()[0])
              : Image.network(_picList[_index].values.toList()[0]));
      _index++;
    });
    await Future.delayed(_duration, () => _framePicList());
  }
}

enum ACEFramePicType { asset, network }
