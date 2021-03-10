import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DismissiblePage extends StatefulWidget {
  @override
  _DismissiblePageState createState() => _DismissiblePageState();
}

class _DismissiblePageState extends State<DismissiblePage> {
  final itemsList = List<String>.generate(20, (n) => '当前 item = $n');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Dismissible Page')), body: _listWid()));
  }

  _listWid() => ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) => _disItem(index));

  _listItem(index) {
    return Column(children: <Widget>[
      Container(
          height: 60.0,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: <Widget>[
            Expanded(
                child:
                    Text(itemsList[index], style: TextStyle(fontSize: 16.0))),
            Padding(
                child: Icon(Icons.lock_open, size: 14.0),
                padding: EdgeInsets.only(left: 10.0))
          ])),
      Container(height: 0.5, color: Colors.grey)
    ]);
  }

  _disItem(index) {
    return Dismissible(
        key: UniqueKey(),
        child: _listItem(index),
        background: _backgroundWid(),
        secondaryBackground: _secondBackgroundWid(),
        direction: DismissDirection.horizontal,
        crossAxisEndOffset: -5.0,
        dragStartBehavior: DragStartBehavior.start,
        dismissThresholds: {
          DismissDirection.startToEnd: 0.8,
          DismissDirection.endToStart: 0.3
        },
        confirmDismiss: (_direction) async {
          if (_direction == DismissDirection.endToStart) {
          } else if (_direction == DismissDirection.startToEnd) {}
          return await _itemDialog(context, _direction, index);
        },
        onDismissed: (_direction) async {
          print('---onDismissed---$_direction');
        },
        onResize: () {
          print('---onResize---');
        });
  }

  _secondBackgroundWid() {
    return Container(
        color: Colors.red,
        child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.delete_forever,
                          color: Colors.white, size: 18.0),
                      SizedBox(height: 5.0),
                      Text('Delete', style: TextStyle(color: Colors.white))
                    ]))));
  }

  _backgroundWid() {
    return Container(
        color: Colors.green,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.edit, color: Colors.white, size: 18.0),
                      SizedBox(height: 5.0),
                      Text('Edit', style: TextStyle(color: Colors.white))
                    ]))));
  }

  _itemDialog(context, _direction, index) {
    bool _value = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(children: <Widget>[
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text(_direction == DismissDirection.endToStart
                    ? 'Delete'
                    : 'Edit')
              ]),
              content: Icon(
                  _direction == DismissDirection.endToStart
                      ? Icons.delete_forever
                      : Icons.edit,
                  color: _direction == DismissDirection.endToStart
                      ? Colors.red
                      : Colors.green),
              actions: <Widget>[
                FlatButton(
                    child: const Text('No'),
                    onPressed: () {
                      setState(() {
                        itemsList.removeAt(index);
                      });
                      Navigator.pop(context, true);
                      _value = false;
                    }),
                FlatButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.pop(context, true);
                      _value = true;
                    })
              ]);
        }).then((val) {
      val = _value;
      return val;
    });
  }

  _listDir() {
    return ListView(children: <Widget>[
      _itemDirection(DismissDirection.vertical, Colors.blue.withOpacity(0.8)),
      _itemDirection(
          DismissDirection.horizontal, Colors.deepOrange.withOpacity(0.8)),
      _itemDirection(
          DismissDirection.endToStart, Colors.green.withOpacity(0.8)),
      _itemDirection(
          DismissDirection.startToEnd, Colors.yellow.withOpacity(0.8)),
      _itemDirection(DismissDirection.up, Colors.pink.withOpacity(0.8)),
      _itemDirection(DismissDirection.down, Colors.teal.withOpacity(0.8)),
    ]);
  }

  _itemDirection(_direction, _color) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Dismissible(
            key: Key('${_direction.toString()}'),
            child: Container(
                height: 100.0,
                child: Center(
                    child: Text('${_direction.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 16.0))),
                decoration: BoxDecoration(
                    color: _color,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0))),
            direction: _direction,
            background: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0)))));
  }
}
