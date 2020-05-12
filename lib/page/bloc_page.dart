import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/color_bloc.dart';
import 'package:flutter_app/bloc/number_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
//  NumberBloc _numBloc = NumberBloc();
//  ColorBloc _colorBloc = ColorBloc();
  NumberBloc _numBloc;

  ColorBloc _colorBloc;

//  @override
//  Widget build(BuildContext context) {
//    return BlocProvider(
//        create: (BuildContext context) => NumberBloc(),
//        child: BlocBuilder<NumberBloc, int>(condition: (previousState, state) {
//          print('BlocPage.condition->$previousState==$state');
//          return state <= 30 ? true : false;
//        }, builder: (context, count) {
//          return Scaffold(
//              appBar: AppBar(title: Text('Bloc Page')),
//              body: Center(
//                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                    Text('当 Number > 30 时，不进行变更',
//                        style: TextStyle(fontSize: 20.0, color: Colors.blue)),
//                    SizedBox(height: 20.0),
//                    Text(
//                        '当前 Number = ${BlocProvider.of<NumberBloc>(context).state}',
//                        style: TextStyle(fontSize: 20.0, color: Colors.blue))
//                  ])),
//              floatingActionButton: Column(
//                  crossAxisAlignment: CrossAxisAlignment.end,
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    FloatingActionButton(
//                        heroTag: 'addTag',
//                        child: Icon(Icons.add),
//                        onPressed: () => BlocProvider.of<NumberBloc>(context)
//                            .add(NumberEvent.addEvent)),
//                    SizedBox(height: 20.0),
//                    FloatingActionButton(
//                        heroTag: 'removeTag',
//                        child: Icon(Icons.remove),
//                        onPressed: () => BlocProvider.of<NumberBloc>(context)
//                            .add(NumberEvent.removeEvent))
//                  ]));
//        }));
//  }
  ///======多个 Bloc 在 build() 方法外注册创建=======
//  @override
//  Widget build(BuildContext context) {
//    return BlocListener<NumberBloc, int>(
//        bloc: _numBloc,
//        listener: (context, count) {
//          print('BlocPage.listene->$count');
//        },
//        condition: (previousState, state) {
//          print('BlocPage.BlocListener.condition->$previousState==$state');
//          return state <= 20 ? true : false;
//        },
//        child: BlocBuilder<NumberBloc, int>(
//            bloc: _numBloc,
//            condition: (previousState, state) {
//              print('BlocPage.condition->$previousState==$state');
//              return state <= 30 ? true : false;
//            },
//            builder: (context, count) {
//              return Scaffold(
//                  appBar: AppBar(
//                      title: Text('Bloc Page'),
//                      actions: <Widget>[_settingWid()]),
//                  body: Container(
//                      color: Colors.white.withGreen(200).withOpacity(0.4),
//                      child: _numberWid()),
//                  floatingActionButton: _floatingWid());
//            }));
//}
  ///======多个 BlocProvider =======
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _numBloc = NumberBloc(),
        child: BlocListener<NumberBloc, int>(
            bloc: _numBloc,
            listener: (context, state) =>
                print('BlocListener--->NumberBloc--->$state'),
            child: BlocBuilder<NumberBloc, int>(
                bloc: _numBloc,
                condition: (previousState, state) {
                  print('BlocPage.condition->$previousState==$state');
                  return state <= 30 ? true : false;
                },
                builder: (context, count) {
                  return BlocProvider(
                      create: (BuildContext context) =>
                          _colorBloc = ColorBloc(),
                      child: BlocListener<ColorBloc, Color>(
                          bloc: _colorBloc,
                          listener: (context, state) =>
                              print('BlocListener--->ColorBloc--->$state'),
                          child: BlocBuilder<ColorBloc, Color>(
                              bloc: _colorBloc,
                              builder: (context, color) {
                                return Scaffold(
                                    appBar: AppBar(
                                        title: Text('Bloc Page'),
                                        actions: <Widget>[_settingWid()]),
                                    body: Container(
                                        color: _colorBloc.state,
                                        child: _numberWid()),
                                    floatingActionButton: _floatingWid());
                              })));
                })));
  }

  ///======MultiBlocProvider 方式=======
//  @override
//  Widget build(BuildContext context) {
//    return MultiBlocProvider(
//        providers: [
//          BlocProvider(
//              create: (BuildContext context) => _numBloc = NumberBloc()),
//          BlocProvider(
//              create: (BuildContext context) => _colorBloc = ColorBloc())
//        ],
//        child: MultiBlocListener(
//            listeners: [
//              BlocListener<NumberBloc, int>(listener: (context, state) {
//                print('BlocListener--->NumberBloc--->$state');
//              }),
//              BlocListener<ColorBloc, Color>(listener: (context, state) {
//                print('BlocListener--->ColorBloc--->$state');
//              })
//            ],
//            child: BlocBuilder<NumberBloc, int>(
//                bloc: _numBloc,
//                condition: (previousState, state) {
//                  print('BlocPage.condition->$previousState==$state');
//                  return state <= 30 ? true : false;
//                },
//                builder: (context, count) {
//                  return BlocBuilder<ColorBloc, Color>(
//                      bloc: _colorBloc,
//                      builder: (context, color) {
//                        return Scaffold(
//                            appBar: AppBar(
//                                title: Text('Bloc Page'),
//                                actions: <Widget>[_settingWid()]),
//                            body: Container(
//                                color: _colorBloc.state, child: _numberWid()),
//                            floatingActionButton: _floatingWid());
//                      });
//                })));
//  }

  _settingWid() {
    return FlatButton(
        onPressed: () => _colorBloc.add(ColorEvent()),
        child: Icon(Icons.settings, color: Colors.white));
  }

  _numberWid() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(
              '当 Number > 20 时，BlocListener 过滤 listener 监听，与 BlocBuilder 中过滤的状态无关',
              style: TextStyle(fontSize: 20.0, color: Colors.red)),
          SizedBox(height: 20.0),
          Text('当 Number > 30 时，Number 不进行变更',
              style: TextStyle(fontSize: 20.0, color: Colors.green)),
          SizedBox(height: 20.0),
          Text('当前 Number = ${_numBloc.state}',
              style: TextStyle(fontSize: 20.0, color: Colors.blue))
        ]));
  }

  _floatingWid() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 'addTag',
              child: Icon(Icons.add),
              onPressed: () => _numBloc.add(NumberEvent.addEvent)),
          SizedBox(height: 20.0),
          FloatingActionButton(
              heroTag: 'removeTag',
              child: Icon(Icons.remove),
              onPressed: () => _numBloc.add(NumberEvent.removeEvent))
        ]);
  }
}
