import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_tabbar.dart';

class ACETabBarPage extends StatefulWidget {
  @override
  _ACETabBarPageState createState() => _ACETabBarPageState();
}

class _ACETabBarPageState extends State<ACETabBarPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TabController _tabController2;

  List<Widget> _tabData01 = [
    Tab(text: '今日', icon: Icon(Icons.account_circle)),
    Tab(text: '今日爆款土货生鲜'),
    Tab(text: '分类')
  ];
  List<Widget> _tabData02 = [
    Tab(text: '今日'),
    Tab(text: '今日爆款土货生鲜'),
    Tab(text: '分类')
  ];
  List<Widget> _tabData03 = [
    Tab(text: '今日', icon: Icon(Icons.account_circle)),
    Tab(text: '今日爆款土货生鲜'),
    Tab(text: '分类'),
    Tab(text: '今日', icon: Icon(Icons.account_circle)),
    Tab(text: '今日爆款土货生鲜'),
    Tab(text: '分类')
  ];
  List<Widget> _tabData04 = [
    Tab(text: '今日'),
    Tab(text: '今日爆款土货生鲜'),
    Tab(text: '分类'),
    Tab(text: '今日'),
    Tab(text: '今日爆款土货生鲜'),
    Tab(text: '分类')
  ];
  List<Widget> _tabViewData01 = [
    Center(child: Text('今日爆款')),
    Center(child: Text('今日爆款土货生鲜')),
    Center(child: Text('分类'))
  ];
  List<Widget> _tabViewData02 = [
    Center(child: Text('今日爆款')),
    Center(child: Text('今日爆款土货生鲜')),
    Center(child: Text('分类')),
    Center(child: Text('今日爆款')),
    Center(child: Text('今日爆款土货生鲜')),
    Center(child: Text('分类'))
  ];

  @override
  void dispose() {
    // _tabController.dispose();
    _tabController2.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    // _tabController = new TabController(vsync: this, length: 3);
    _tabController2 = new TabController(vsync: this, length: 6);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: ListView(children: <Widget>[
      // _tabBarWid01(),
      // _tabBarWid02(),
      // _tabBarWid03(),
      // _tabBarWid04(),
      _tabBarWid05(),
      _tabBarWid06(),
      _tabBarWid07(),
      _tabBarWid08(),
    ])));
  }

  _tabBarView(type) => TabBarView(
      controller: type == 0 ? _tabController : _tabController2,
      children: type == 0 ? _tabViewData01 : _tabViewData02);

  _tabBar01(type) => ACETabBar(
      isScrollable: true,
      controller: type == 0 ? _tabController : _tabController2,
      tabs: type == 0 ? _tabData01 : _tabData03);

  _tabBar02(type) => ACETabBar(
      isScrollable: true,
      alignType: ACETabBarAlignType.left,
      controller: type == 0 ? _tabController : _tabController2,
      tabs: type == 0 ? _tabData02 : _tabData04);

  _tabBar03(type) => ACETabBar(
      isScrollable: true,
      alignType: ACETabBarAlignType.right,
      controller: type == 0 ? _tabController : _tabController2,
      tabs: type == 0 ? _tabData02 : _tabData04);

  _tabBar04(type) => ACETabBar(
      isScrollable: false,
      alignType: ACETabBarAlignType.right,
      controller: type == 0 ? _tabController : _tabController2,
      tabs: type == 0 ? _tabData02 : _tabData04);

  _tabBar05(type, isLeft, isRight, {isScrollable}) => ACETabBar(
      isScrollable: isScrollable ?? true,
      alignType: ACETabBarAlignType.left,
      startIcon: isLeft
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: FlutterLogo())
          : null,
      endIcon: isRight
          ? GestureDetector(
              onTap: () => print('----endIcon.click----'),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.add, color: Colors.white)))
          : null,
      controller: type == 0 ? _tabController : _tabController2,
      tabs: type == 0 ? _tabData02 : _tabData04);

  _tabBarWid01() => Container(
      height: 200.0,
      child: Scaffold(
          appBar: AppBar(
              title: Text('isScrollable = true & Center'),
              bottom: _tabBar01(0)),
          body: _tabBarView(0)));

  _tabBarWid02() => Container(
      height: 200.0,
      child: Scaffold(
          appBar: AppBar(
              title: Text('isScrollable = true & Left'), bottom: _tabBar02(0)),
          body: _tabBarView(0)));

  _tabBarWid03() => Container(
      height: 200.0,
      child: Scaffold(
          appBar: AppBar(
              title: Text('isScrollable = true & Right'), bottom: _tabBar03(0)),
          body: _tabBarView(0)));

  _tabBarWid04() => Container(
      height: 200.0,
      child: Scaffold(
          appBar:
              AppBar(title: Text('isScrollable = false'), bottom: _tabBar04(0)),
          body: _tabBarView(0)));

  _tabBarWid05() => Container(
      height: 200.0,
      child: Scaffold(
          appBar: AppBar(
              title: Text('isScrollable = true & Left & LeftIcon'),
              bottom: _tabBar05(1, true, false)),
          body: _tabBarView(1)));

  _tabBarWid06() => Container(
      height: 200.0,
      child: Scaffold(
          appBar: AppBar(
              title: Text('isScrollable = true & Left & RightIcon'),
              bottom: _tabBar05(1, false, true)),
          body: _tabBarView(1)));

  _tabBarWid07() => Container(
      height: 200.0,
      child: Scaffold(
          appBar: AppBar(
              title: Text('true & LeftIcon & RightIcon'),
              bottom: _tabBar05(1, true, true)),
          body: _tabBarView(1)));

  _tabBarWid08() => Container(
      height: 200.0,
      child: Scaffold(
          appBar: AppBar(
              title: Text('false & LeftIcon & RightIcon'),
              bottom: _tabBar05(1, true, true, isScrollable: false)),
          body: _tabBarView(1)));
}
