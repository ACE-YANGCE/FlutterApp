import 'dart:async';

import 'package:flutter/material.dart';

class ACETimerButton extends StatefulWidget {
  final int timeout;
  final Color color;
  final String preName;

  ACETimerButton(this.timeout, {this.color, this.preName});

  @override
  _ACETimerButtonState createState() => _ACETimerButtonState();
}

class _ACETimerButtonState extends State<ACETimerButton> {
  Timer _timer;
  int _timeOut;
  String _name;
  bool _isClick = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () {
        if (!_isClick) {
          _startTimer();
        }
        _isClick = true;
      },
      child: Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4.0)),
          child: Center(
              child: Text(_name ?? 'click',
                  style: TextStyle(
                      color: widget.color ?? Colors.blue, fontSize: 16.0)))));

  @override
  void initState() {
    super.initState();
    _name = widget.preName;
    _timeOut = widget.timeout;
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeOut--;
        _name = '$_timeOut s';
      });
      if (_timeOut == 0) {
        _cancelTimer();
        _isClick = false;
        _name = widget.preName;
        _timeOut = widget.timeout;
      }
    });
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    _isClick = false;
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }
}
