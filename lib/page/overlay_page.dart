import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_bottom_navigation_bar.dart';
import 'package:flutter_app/widget/bubble_widget.dart';

class OverLayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OverLayStatePage();
}

class OverLayStatePage extends State<OverLayPage> {
  OverlayEntry overlayEntry, overlayEntry2, overlayEntry3, overlayEntry0;
  List<OverlayEntry> overlayEntryList = List<OverlayEntry>();
  var width, height, overIndex, overListIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _itemGuide();
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(title: Text('Overlay Page'), actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.settings, color: Colors.white))
            ]),
            body: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _itemBtn(
                          '展示一个 OverlayEntry', 1, Colors.blue.withOpacity(0.4)),
                      _itemBtn('展示一个 OverlayEntry (List)', 2,
                          Colors.brown.withOpacity(0.4)),
                      _itemBtn('一次展示多个 OverlayEntry (List)', 3,
                          Colors.red.withOpacity(0.4)),
                      _itemBtn('逐次展示多个 OverlayEntry (List)', 4,
                          Colors.indigo.withOpacity(0.4)),
                      _itemBtn('Opaque Test', 5, Colors.green.withOpacity(0.4)),
                    ])),
            floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: FloatingActionButton(
                    onPressed: null, child: Icon(Icons.android))),
            bottomNavigationBar: ACEBottomNavigationBar(
                type: ACEBottomNavigationBarType.protruding,
                textUnSelectedColor: Colors.orange,
                textSelectedColor: Colors.indigo,
                protrudingColor: Colors.lightBlueAccent,
                items: [
                  NavigationItemBean(
                      textStr: 'Home',
                      textUnSelectedColor: Colors.green,
                      textSelectedColor: Colors.indigo,
                      image: AssetImage('images/icon_qq.png'),
                      imageSelected:
                          AssetImage('images/icon_wechat_moments.png')),
                  NavigationItemBean(
                      textStr: 'Book',
                      textUnSelectedColor: Colors.green,
                      textSelectedColor: Colors.orange,
                      icon: Icons.book,
                      iconUnSelectedColor: Colors.indigoAccent,
                      iconSelectedColor: Colors.pinkAccent),
                  NavigationItemBean(
                      textStr: 'WeChat',
                      image: AssetImage('images/icon_wechat.png')),
                  NavigationItemBean(
                      textStr: 'Time',
                      icon: Icons.schedule,
                      iconUnSelectedColor: Colors.blue,
                      iconSelectedColor: Colors.pinkAccent),
                  NavigationItemBean(
                      textStr: 'User', icon: Icons.supervised_user_circle)
                ],
                onTabChangedListener: (index) {})),
        onWillPop: () async {
          if (overListIndex == 6) {
            for (int i = overlayEntryList.length; i > 0; i--) {
              overlayEntryList[i - 1].remove();
            }
            overlayEntryList.clear();
            overIndex = 0;
          } else if (overListIndex == 7) {
            overlayEntry.remove();
          } else if (overListIndex == 8) {
            overlayEntry2.remove();
          } else if (overListIndex == 9) {
            overlayEntry3.remove();
          }
          if (overIndex == 4) {
            overlayEntry.remove();
            overlayEntry0.remove();
          } else if (overIndex == 3) {
            overlayEntry2.remove();
            overlayEntry0.remove();
          } else if (overIndex == 2) {
            overlayEntry3.remove();
            overlayEntry0.remove();
          } else if (overIndex == 5) {
            overlayEntry.remove();
          }
          overIndex = 0;
          return true;
        });
  }

  _itemGuideTop() {
    return Material(
        color: Color.fromARGB(0, 0, 0, 0),
        child: Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: Container(
                child: BubbleWidget(
                    180.0,
                    60.0,
                    Colors.deepOrange.withOpacity(0.7),
                    BubbleArrowDirection.top,
                    length: 140.0,
                    child: Text('This is Setting Button!',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Colors.white, fontSize: 16.0))))));
  }

  _itemGuideRight() {
    return Material(
        color: Color.fromARGB(0, 0, 0, 0),
        child: Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: Container(
                child: BubbleWidget(240.0, 50.0, Colors.green.withOpacity(0.7),
                    BubbleArrowDirection.right,
                    child: Text('This is FloatingActionButton!',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Colors.white, fontSize: 16.0))))));
  }

  _itemGuideBottom() {
    return Material(
        color: Color.fromARGB(0, 0, 0, 0),
        child: Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: Container(
                child: BubbleWidget(
                    260.0,
                    80.0,
                    Colors.pinkAccent.withOpacity(0.7),
                    BubbleArrowDirection.bottom,
                    child: Text('This is ACEBottomNavigationBar! \nindex = 3',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Colors.white, fontSize: 16.0))))));
  }

  _itemGuide() {
    overIndex = 4;
    overlayEntry0 = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        GestureDetector(
            onTap: () {
              --overIndex;
              if (overIndex == 3) {
                overlayEntry.remove();
                overlayEntryList.removeLast();
                Overlay.of(this.context).insert(overlayEntry2);
              } else if (overIndex == 2) {
                overlayEntry2.remove();
                Overlay.of(this.context).insert(overlayEntry3);
              } else if (overIndex == 1) {
                overlayEntry3.remove();
                overlayEntry0.remove();
                overlayEntryList.removeLast();
              }
            },
            child: Container(color: Colors.black.withOpacity(0.4)))
      ]);
    });
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: 75,
            left: width - 185.0,
            child: GestureDetector(
                onTap: () {
                  --overIndex;
                  overlayEntry.remove();
                  overlayEntryList.removeLast();
                  Overlay.of(this.context).insert(overlayEntry2);
                },
                child: _itemGuideTop()))
      ]);
    });
    overlayEntryList.add(overlayEntry0);
    overlayEntryList.add(overlayEntry);
    overlayEntry2 = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            bottom: 105,
            right: 80,
            child: GestureDetector(
                onTap: () {
                  --overIndex;
                  overlayEntry2.remove();
                  Overlay.of(this.context).insert(overlayEntry3);
                },
                child: _itemGuideRight()))
      ]);
    });
    overlayEntry3 = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            bottom: 85,
            left: (width - 260) * 0.5,
            child: GestureDetector(
                onTap: () {
                  --overIndex;
                  overlayEntry3.remove();
                  overlayEntry0.remove();
                  overlayEntryList.removeLast();
                },
                child: _itemGuideBottom()))
      ]);
    });
    Overlay.of(context).insertAll(overlayEntryList);
  }

  _itemOneGuide01() {
    overIndex = 5;
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5,
            left: (width - 200) * 0.5,
            child: GestureDetector(
                onTap: () => overlayEntry.remove(),
                child: _itemContainer(Colors.blue.withOpacity(0.6))))
      ]);
    });
    Overlay.of(context).insert(overlayEntry);
  }

  _itemOneGuide02() {
    overIndex = 5;
    overlayEntry = OverlayEntry(
        opaque: false,
        maintainState: true,
        builder: (context) {
          return Stack(children: <Widget>[
            Positioned(
                top: (height - 200) * 0.5,
                left: (width - 200) * 0.5,
                child: GestureDetector(
                    onTap: () {
                      overlayEntry.remove();
                      overlayEntryList.clear();
                    },
                    child: _itemContainer(Colors.brown.withOpacity(0.6))))
          ]);
        });
    overlayEntryList.add(overlayEntry);
    Overlay.of(context).insertAll(overlayEntryList);
  }

  _itemThreeGuide01() {
    overListIndex = 6;
    overlayEntryList.add(OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5 - 50,
            left: (width - 200) * 0.5 - 50,
            child: GestureDetector(
                onTap: () {
                  --overIndex;
                  overlayEntryList[overIndex].remove();
                  overlayEntryList.removeLast();
                },
                child: _itemContainer(Colors.red.withOpacity(0.6))))
      ]);
    }));
    overlayEntryList.add(OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5,
            left: (width - 200) * 0.5,
            child: GestureDetector(
                onTap: () {
                  --overIndex;
                  overlayEntryList[overIndex].remove();
                  overlayEntryList.removeLast();
                },
                child: _itemContainer(Colors.orange.withOpacity(0.6))))
      ]);
    }));
    overlayEntryList.add(OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5 + 50,
            left: (width - 200) * 0.5 + 50,
            child: GestureDetector(
                onTap: () {
                  --overIndex;
                  overlayEntryList[overIndex].remove();
                  overlayEntryList.removeLast();
                },
                child: _itemContainer(Colors.blue.withOpacity(0.6))))
      ]);
    }));
    overIndex = overlayEntryList.length;
    Overlay.of(context).insertAll(overlayEntryList);
  }

  _itemThreeGuide02() {
    overListIndex = 7;
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5 - 50,
            left: (width - 200) * 0.5 - 50,
            child: GestureDetector(
                onTap: () {
                  overListIndex = 8;
                  overlayEntry.remove();
                  Overlay.of(this.context).insert(overlayEntry2);
                },
                child: _itemContainer(Colors.red.withOpacity(0.6))))
      ]);
    });
    overlayEntry2 = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5,
            left: (width - 200) * 0.5,
            child: GestureDetector(
                onTap: () {
                  overListIndex = 9;
                  overlayEntry2.remove();
                  Overlay.of(this.context).insert(overlayEntry3);
                },
                child: _itemContainer(Colors.orange.withOpacity(0.6))))
      ]);
    });
    overlayEntry3 = OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5 + 50,
            left: (width - 200) * 0.5 + 50,
            child: GestureDetector(
                onTap: () {
                  overListIndex = 10;
                  overlayEntry3.remove();
                },
                child: _itemContainer(Colors.blue.withOpacity(0.6))))
      ]);
    });
    Overlay.of(context).insert(overlayEntry);
  }

  _itemOpaqueTest() {
    overlayEntryList.add(OverlayEntry(builder: (context) {
      return Stack(children: <Widget>[
        Positioned(
            top: (height - 200) * 0.5 - 50,
            left: (width - 200) * 0.5 - 50,
            child: GestureDetector(
                onTap: () {
                  --overIndex;
                  overlayEntryList[overIndex].remove();
                  overlayEntryList.removeLast();
                },
                child: _itemContainer(Colors.red.withOpacity(0.6))))
      ]);
    }));
    overlayEntryList.add(OverlayEntry(
        opaque: true,
        maintainState: true,
        builder: (context) {
          return Material(
              color: Colors.amber.withOpacity(0.4),
              child: Stack(children: <Widget>[
                Positioned(
                    top: (height - 200) * 0.5,
                    left: (width - 200) * 0.5,
                    child: GestureDetector(
                        onTap: () {
                          --overIndex;
                          overlayEntryList[overIndex].remove();
                          overlayEntryList.removeLast();
                        },
                        child: _itemContainer(Colors.orange.withOpacity(0.6))))
              ]));
        }));
    overlayEntryList.add(OverlayEntry(
        opaque: true,
        maintainState: false,
        builder: (context) {
          return Material(
              color: Colors.lightBlueAccent.withOpacity(0.4),
              child: Stack(children: <Widget>[
                Positioned(
                    top: (height - 200) * 0.5 + 50,
                    left: (width - 200) * 0.5 + 50,
                    child: GestureDetector(
                        onTap: () {
                          --overIndex;
                          overlayEntryList[overIndex].remove();
                          overlayEntryList.removeLast();
                        },
                        child: _itemContainer(Colors.blue.withOpacity(0.6))))
              ]));
        }));
    overIndex = overlayEntryList.length;
    Overlay.of(context).insertAll(overlayEntryList);
  }

  _itemContainer(color) {
    return Container(
        width: 200,
        height: 200,
        color: color,
        child: Center(child: Icon(Icons.ac_unit, color: Colors.white)));
  }

  _itemBtn(text, index, color) {
    return FlatButton(
        onPressed: () => _itemClick(index),
        child: Center(
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 16.0))),
        color: color);
  }

  _itemClick(index) {
    switch (index) {
      case 1:
        _itemOneGuide01();
        break;
      case 2:
        _itemOneGuide02();
        break;
      case 3:
        _itemThreeGuide01();
        break;
      case 4:
        _itemThreeGuide02();
        break;
      case 5:
        _itemOpaqueTest();
        break;
    }
  }
}
