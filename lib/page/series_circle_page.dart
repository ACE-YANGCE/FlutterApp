import 'package:flutter/material.dart';
import 'package:flutter_app/widget/series_circle_profile.dart';

class SeriesCirclePage extends StatefulWidget {
  @override
  _SeriesCirclePageState createState() => new _SeriesCirclePageState();
}

class _SeriesCirclePageState extends State<SeriesCirclePage> {
  List<String> _list = [
    'images/icon_hzw01.jpg',
    'images/icon_hzw02.jpg',
    'images/icon_hzw03.jpg',
    'images/icon_hzw01.jpg',
    'images/icon_hzw02.jpg',
    'images/icon_hzw03.jpg',
    'images/icon_hzw01.jpg'
  ];
  List<Map<bool, String>> _mixList = [
    Map.from({true: 'images/icon_hzw01.jpg'}),
    Map.from({
      false:
          'https://locadeserta.com/game/assets/images/background/landing/1.jpg'
    }),
    Map.from({
      false:
          'https://locadeserta.com/game/assets/images/background/landing/2.jpg'
    }),
    Map.from({
      false:
          'https://locadeserta.com/game/assets/images/background/landing/3.jpg'
    }),
    Map.from({true: 'images/icon_hzw02.jpg'}),
    Map.from({true: 'images/icon_hzw03.jpg'}),
    Map.from({
      false:
          'https://locadeserta.com/game/assets/images/background/landing/4.jpg'
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('SeriesCircle Page')),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(children: <Widget>[
              SeriesCircleProfile(60.0,
                  urlList: _list, isAsset: true, spaceWidth: 40.0),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  urlList: _list,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isBorder: true),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  urlList: _list,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isBorder: true,
                  borderColor: Colors.deepOrange,
                  endIcon: Icon(Icons.more_horiz)),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  urlList: _list,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isBorder: true,
                  borderColor: Colors.deepOrange,
                  borderWidth: 3.0),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  urlList: _list,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isCoverUp: false),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  urlList: _list,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isCoverUp: false,
                  isBorder: true,
                  borderColor: Colors.deepOrange),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  urlList: _list,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isCoverUp: false,
                  isBorder: true,
                  borderColor: Colors.deepOrange,
                  borderWidth: 1.0,
                  endIcon: Icon(Icons.more_horiz)),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  mixUrlList: _mixList,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isCoverUp: true,
                  isBorder: true,
                  borderColor: Colors.deepOrange,
                  borderWidth: 2.0,
                  endIcon: Icon(Icons.more_horiz)),
              SizedBox(height: 20.0),
              SeriesCircleProfile(60.0,
                  mixUrlList: _mixList,
                  isAsset: true,
                  spaceWidth: 40.0,
                  isCoverUp: false,
                  isBorder: true,
                  borderColor: Colors.deepOrange,
                  borderWidth: 3.0,
                  endIcon: Icon(Icons.more_horiz)),
              SizedBox(height: 60.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_itemCircle01(0), _itemCircle01(1)]),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_itemCircle02(0), _itemCircle02(1)]),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_itemCircle03(0), _itemCircle03(1)]),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _itemCircle04(),
                    _itemCircle05(),
                    _itemCircle06(),
                    _itemCircle07()
                  ]),
            ])));
  }

  _itemCircle01(index) {
    return CircleAvatar(radius: 40.0, child: Text(index == 0 ? 'ACE' : 'Hi'));
  }

  _itemCircle02(index) {
    return CircleAvatar(
        radius: 40.0,
        backgroundImage: index != 0
            ? NetworkImage(
                'https://locadeserta.com/game/assets/images/background/landing/1.jpg')
            : AssetImage('images/icon_hzw01.jpg'));
  }

  _itemCircle03(index) {
    return CircleAvatar(
        radius: 40.0,
        child: Text(index == 0 ? 'ACE' : 'Hi'),
        backgroundColor: (index == 0) ? null : Colors.deepOrange,
        foregroundColor: (index == 0) ? null : Colors.blue);
  }

  _itemCircle04() {
    return CircleAvatar(
        child: Text('ACE'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white);
  }

  _itemCircle05() {
    return CircleAvatar(
        minRadius: 30.0,
        child: Text('ACE'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white);
  }

  _itemCircle06() {
    return CircleAvatar(
        radius: 40.0,
        child: Text('ACE'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        backgroundImage: AssetImage('images/icon_hzw01.jpg'));
  }

  _itemCircle07() {
    return CircleAvatar(
        maxRadius: 50.0,
        child: Text('ACE'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        backgroundImage: NetworkImage(
            'https://locadeserta.com/game/assets/images/background/landing/1.jpg'));
  }
}
