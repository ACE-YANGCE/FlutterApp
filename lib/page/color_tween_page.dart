import 'package:flutter/material.dart';

class ColorTweenPage extends StatefulWidget {
  @override
  _ColorTweenPageState createState() => new _ColorTweenPageState();
}

class _ColorTweenPageState extends State<ColorTweenPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colors;
  Color _currentColor = Colors.black;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: Duration(seconds: 5),
    //   vsync: this,
    // )..repeat(reverse: true);
    //
    // _color =
    //     ColorTween(begin: Colors.blue, end: Colors.amber).animate(_controller);
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _colors = ColorTween(begin: _currentColor, end: Colors.amber)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _bodyWid();

  _bodyWid() => Material(
      child: AnimatedBuilder(
          animation: _colors,
          builder: (BuildContext _, Widget childWidget) {
            return Scaffold(
                backgroundColor: _colors.value, body: _itemListWid());
          }));

  _itemListWid() => ListView.builder(
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _titleCard();
        } else if (index == 1) {
          return _changeColorWid();
        } else {
          return ListTile(
              title: Text('当前 item 为: ${(index + 1)}'),
              tileColor: Colors.white);
        }
      });

  _bodyWid01() => Scaffold(
      body: Container(
          alignment: Alignment.center,
          color: Colors.black87,
          child: AnimatedBuilder(
              animation: _colors,
              builder: (BuildContext _, Widget childWidget) {
                return Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        color: _colors.value, shape: BoxShape.circle));
              })));

  _titleCard() =>
      Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Container(height: 40.0, color: Colors.white),
        Stack(alignment: AlignmentDirectional.topEnd, children: [
          Container(
              margin: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
              decoration: BoxDecoration(
                  color: Color(0xffd8d8d8),
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(children: [
                SizedBox(height: 20),
                Row(children: [
                  SizedBox(width: 20.0),
                  _userProfile(),
                  SizedBox(width: 20.0),
                  _userDetail()
                ]),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Divider(height: 0.5, color: Colors.black)),
                Text('开通会员有惊喜哦！'),
                SizedBox(height: 12.0)
              ])),
          Padding(
              padding: EdgeInsets.only(top: 45.0, right: 35.0),
              child: _vipBtn())
        ])
      ]);

  _userProfile() => PhysicalModel(
      color: Colors.transparent,
      shape: BoxShape.circle,
      clipBehavior: Clip.antiAlias,
      child: Container(
          width: 60, height: 60, child: Image.asset('images/icon_hzw01.jpg')));

  _userDetail() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('阿策小和尚',
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.0),
        Text('这个人很懒，什么都没留下!', style: TextStyle(fontSize: 13.0))
      ]);

  _vipBtn() => Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: BoxDecoration(
          color: Colors.deepOrange, borderRadius: BorderRadius.circular(24.0)),
      child: Text('Super VIP',
          style: TextStyle(color: Colors.white, fontSize: 12.0)));

  _changeColorWid() => Container(
      color: Colors.white,
      child: Column(children: [
        ListTile(title: Text('切换 ThemeColor：')),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _itemColorWid(Colors.deepOrange),
          _itemColorWid(Colors.teal),
          _itemColorWid(Colors.blue),
          _itemColorWid(Colors.pink),
          _itemColorWid(Colors.indigoAccent)
        ])
      ]));

  _itemColorWid(color) => GestureDetector(
      child: Container(width: 50.0, height: 50.0, color: color),
      onTap: () {
        _colors =
            ColorTween(begin: _currentColor, end: color).animate(_controller);
        setState(() {
          _controller.reset();
          _controller.forward();
        });
        _currentColor = color;
      });
}
