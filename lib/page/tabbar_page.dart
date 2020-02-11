import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_tabbar_indicator.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => new _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 8);
  }

//  @override
//  Widget build(BuildContext context) => DefaultTabController(
//      length: 4,
//      child: Scaffold(
//          appBar: AppBar(
//              title: Text('TabBar Page'),
//              bottom: TabBar(tabs: <Widget>[
//                Tab(text: '今日爆款'),
//                Tab(text: '土货生鲜'),
//                Tab(text: '会员中心'),
//                Tab(text: '分类')
//              ])),
//          body: TabBarView(children: <Widget>[
//            Center(child: Text('今日爆款')),
//            Center(child: Text('土货生鲜')),
//            Center(child: Text('会员中心')),
//            Center(child: Text('分类'))
//          ])));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Column(children: <Widget>[
      Expanded(
          child: Scaffold(
              appBar:
                  AppBar(title: Text('TabBar Page Top'), bottom: _tabBarTop()),
              body: _tabBarView())),
      Expanded(
          child: Scaffold(
              appBar:
                  AppBar(title: Text('TabBar Page'), bottom: _tabBarBottom()),
              body: _tabBarView()))
//          Expanded(
//              child: Scaffold(
//                  appBar: AppBar(title: _tabBarBottom()), body: _tabBarView())),
//          Expanded(
//              child: Scaffold(
//                  appBar: AppBar(
//                      title: _tabBarBottom(),
//                      leading: Icon(Icons.android),
//                      actions: <Widget>[
//                        Padding(
//                            padding: EdgeInsets.symmetric(horizontal: 10),
//                            child: Icon(Icons.list))
//                      ]),
//                  body: _tabBarView()))
    ]));
  }

  _tabBarView() => TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
//            dragStartBehavior: DragStartBehavior.down,
          children: <Widget>[
            Center(child: Text('今日爆款')),
            Center(child: Text('土货生鲜')),
            Center(child: Text('会员中心')),
            Center(child: Text('分类')),
            Center(child: Text('今日爆款')),
            Center(child: Text('土货生鲜')),
            Center(child: Text('会员中心')),
            Center(child: Text('分类'))
          ]);

  _tabBarTop() => TabBar(tabs: <Widget>[
        Tab(text: '今日爆款'),
        Tab(text: '土货生鲜'),
        Tab(text: '会员中心'),
        Tab(text: '分类'),
        Tab(text: '今日爆款'),
        Tab(text: '土货生鲜'),
        Tab(text: '会员中心'),
        Tab(text: '分类')
      ], controller: _tabController);

  _tabBarBottom() => TabBar(
      indicatorColor: Colors.redAccent,
      indicatorWeight: 4,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.all(5),
      labelColor: Colors.redAccent,
      labelStyle: TextStyle(color: Colors.green, fontSize: 16),
      labelPadding: EdgeInsets.all(4),
      unselectedLabelColor: Colors.white,
      unselectedLabelStyle: TextStyle(color: Colors.purpleAccent, fontSize: 14),
      dragStartBehavior: DragStartBehavior.down,
      indicator: ACETabBarIndicator(),
      isScrollable: true,
      tabs: <Widget>[
        Tab(text: '今日爆款'),
        Tab(text: '土货生鲜'),
        Tab(text: '会员中心'),
        Tab(
            child: Text('分类',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        Tab(text: '今日爆款'),
        Tab(text: '土货生鲜'),
        Tab(text: '会员中心'),
        Tab(text: '分类')
      ],
      controller: _tabController);
}
