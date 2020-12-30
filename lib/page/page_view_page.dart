import 'package:flutter/material.dart';

class PageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  var _currentIndex = 0;
  PageController _controller;
  var _initialIndex = 1;
  var _currentPageValue = 0.0;
  var _scaleFactor = 0.75;

  @override
  void initState() {
    super.initState();
//    _controller = PageController();
    _controller =
        PageController(initialPage: _initialIndex, viewportFraction: 0.75);
    _currentPageValue = _initialIndex * 1.0;
    _controller.addListener(() {
      print('--CurrentPage--${_controller.page}');
      _currentPageValue = _controller.page;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("PageView Page")), body: _bodyWid04());
  }

  _bodyWid01() {
    return Container(
        height: 240,
        child: PageView(
//            physics: ClampingScrollPhysics(),
            physics: BouncingScrollPhysics(),
            controller: _controller,
            onPageChanged: (position) =>
                print('Current index = ${position + 1}'),
            children: <Widget>[
              _itemCard(0),
              _itemCard(1),
              _itemCard(2),
              _itemCard(3)
            ]));
  }

  _bodyWid02() {
    return Container(
        height: 240,
        child: PageView.builder(
            itemBuilder: (context, position) => _itemCard(position),
            itemCount: 4,
            controller: _controller,
            onPageChanged: (position) {
              print('PageView.onPageChanged---$position');
              setState(() {
                if (_currentIndex != position) {
                  _currentIndex = position;
                }
              });
            }));
  }

  _bodyWid03() {
    return Column(children: <Widget>[
      Container(
          height: 60,
          color: Colors.green.withOpacity(0.8),
          child: Row(children: <Widget>[
            Expanded(
                child: GestureDetector(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('目录',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white)),
                          Icon(Icons.arrow_downward, color: Colors.white)
                        ]),
                    onTap: () {
                      print('---GestureDetector--目录---');
                      setState(() {});
                      _currentIndex = 0;
                      _controller.animateToPage(0,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    })),
            Container(width: 0.5, color: Colors.white),
            Expanded(
                child: GestureDetector(
                    child: Center(
                        child: Text('书签',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.white))),
                    onTap: () {
                      print('---GestureDetector--书签---');
                      setState(() {});
                      _currentIndex = 1;
                      _controller.animateToPage(1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }))
          ])),
      _leftMenuPage()
    ]);
  }

  _bodyWid04() {
    return Container(
        height: 240,
        child: PageView.custom(
            controller: _controller,
            childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => _itemTransCard(index),
                childCount: 4)));
  }

  _itemCard(index) {
    Color color;
    switch (index) {
      case 0:
        color = Colors.green.withOpacity(0.8);
        break;
      case 1:
        color = Colors.red.withOpacity(0.8);
        break;
      case 2:
        color = Colors.yellow.withOpacity(0.8);
        break;
      case 3:
        color = Colors.blue.withOpacity(0.8);
        break;
    }
    return Card(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Center(
            child: Text('Current PageView Index = ${index + 1}',
                style: TextStyle(color: Colors.white, fontSize: 16))));
  }

  _leftMenuPage() {
    return Expanded(
        child: PageView.builder(
            itemBuilder: (context, position) =>
                _leftItemPage(context, position),
            itemCount: 2,
            controller: _controller,
            onPageChanged: (position) {
              print('PageView.onPageChanged---$position');
              setState(() {
                if (_currentIndex != position) {
                  _currentIndex = position;
                }
              });
            }));
  }

  _leftItemPage(context, position) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
            child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Text(
                                    position == 0
                                        ? '目录 Tab 下当前 item '
                                            '= ${index + 1}'
                                        : '书签 Tab 下当前 item '
                                            '= ${index + 1}',
                                    style: TextStyle(fontSize: 16.0))),
                            Padding(
                                child: Icon(Icons.lock_open, size: 14.0),
                                padding: EdgeInsets.only(left: 10.0))
                          ])),
                      onTap: () {});
                })));
  }

  _itemTransCard(index) {
    Matrix4 _matrix = Matrix4.identity();
    print('---_itemTransCard-${_currentPageValue.floor()}-');
    if (index == _currentPageValue.floor()) {
      // The Current Page Item
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = 240.0 * (1 - currScale) / 2;
      _matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      return Transform(transform: _matrix, child: _itemCard(index));
    } else if (index == _currentPageValue.floor() + 1) {
      // The Right Page Item
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = 240.0 * (1 - currScale) / 2;
      _matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      return Transform(transform: _matrix, child: _itemCard(index));
    } else if (index == _currentPageValue.floor() - 1) {
      // The Left Page Item
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = 240.0 * (1 - currScale) / 2;
      _matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
      return Transform(transform: _matrix, child: _itemCard(index));
    } else {
      // Else
      _matrix = Matrix4.diagonal3Values(1.0, _scaleFactor, 1.0)
        ..setTranslationRaw(0.0, 240.0 * (1 - _scaleFactor) / 2, 0.0);
      return Transform(transform: _matrix, child: _itemCard(index));
    }
  }
}
