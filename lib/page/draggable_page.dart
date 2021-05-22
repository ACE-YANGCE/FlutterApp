import 'dart:ui';

import 'package:flutter/material.dart';

class DraggablePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  var _itemKey = GlobalKey();
  var _dragState = false;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(title: Text('Draggable Page')),
            body: _draggableWid()));
  }

  _draggableWid02() {
    return ListView(children: <Widget>[
      Icon(Icons.access_alarm, size: 100),
      Icon(Icons.print, size: 100),
      Icon(Icons.android, size: 100),
      Draggable(
        child: Icon(Icons.ac_unit, size: 150, color: Colors.blue),
        feedback: Icon(Icons.ac_unit, size: 200, color: Colors.red),
        affinity: Axis.horizontal,
        feedbackOffset: Offset(300, 100),
      ),
      Icon(Icons.directions_car, size: 100),
      Icon(Icons.sync, size: 100),
      Icon(Icons.error, size: 100),
      Icon(Icons.send, size: 100),
      Icon(Icons.call, size: 100)
    ]);
  }

  _draggableWid() {
    return Column(children: <Widget>[
      Expanded(
          child: Center(
              child: Draggable(
                  affinity: Axis.horizontal,
                  axis: null,
                  child: Image.asset('images/icon_hzw01.jpg',
                      width: 150.0, key: _itemKey),
                  feedback: Image.asset('images/icon_hzw01.jpg', width: 150.0),
                  childWhenDragging: Container(),
                  dragAnchor: DragAnchor.child,
                  maxSimultaneousDrags: 1,
                  data: 'Draggable Data A !!!',
                  onDragCompleted: () => print('Draggable --> onDragCompleted'),
                  onDragEnd: (DraggableDetails details) =>
                      print('Draggable --> onDragEnd --> ${details.offset}'),
                  onDraggableCanceled: (Velocity velocity, Offset offset) =>
                      print('Draggable --> onDraggableCanceled --> $offset'),
                  onDragStarted: () => print('Draggable --> onDragStarted')))),
      Divider(height: 1.0, color: Colors.blue),
      Expanded(
          child: Center(
              child: DragTarget<String>(builder: (BuildContext context,
                  List<String> candidateData, List<dynamic> rejectedData) {
        print(
            'DragTarget --> builder --> $candidateData --> $rejectedData -->$_dragState');
        return _dragState
            ? Image.asset('images/icon_hzw01.jpg', width: 150.0)
            : Container(
                height: 150.0,
                width: 150.0,
                color: Colors.blue.withOpacity(0.4));
      }, onAccept: (String data) {
        print('DragTarget --> onAccept --> $data -->$_dragState');
        setState(() {
          _dragState = true;
        });
        // }, onLeave: (String data) {
        //   print('DragTarget --> onLeave --> $data');
      }, onWillAccept: (String data) {
        print('DragTarget --> onWillAccept --> $data');
        return true;
      })))
    ]);
  }
}
