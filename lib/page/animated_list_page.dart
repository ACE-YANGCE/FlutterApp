import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  @override
  _AnimatedListPageState createState() => new _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  final key = GlobalKey<AnimatedListState>();
  static final List<UserBean> animatedList = [
    UserBean('Monday', 'images/icon_hzw01.jpg'),
    UserBean('Tuesday', 'images/icon_hzw02.jpg'),
    UserBean('Wednesday', 'images/icon_hzw03.jpg'),
    UserBean('Thursday', 'images/icon_hzw01.jpg'),
    UserBean('Friday', 'images/icon_hzw02.jpg'),
    UserBean('Saturday', 'images/icon_hzw03.jpg'),
    UserBean('Sunday', 'images/icon_hzw01.jpg')
  ];
  static final addItem = UserBean('Add Item', 'images/icon_music.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(title: Text('AnimatedList Page')),
        body: AnimatedList(
            key: key,
            reverse: false,
            initialItemCount: animatedList.length,
            itemBuilder: (context, index, animation) =>
                _buildItem4(animatedList[index], index, animation)),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _insertItem(animatedList.length, addItem),
            child: Icon(Icons.add, color: Colors.white)));
  }

  _buildItem(item, index, animation) =>
      FadeTransition(opacity: animation, child: _itemWid(item, index));

  _buildItem2(item, index, animation) => SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
          CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
              reverseCurve: Curves.linear)),
      child: _itemWid(item, index));

  _buildItem3(item, index, animation) => SlideTransition(
      position: Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
          CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
              reverseCurve: Curves.linear)),
      child: SizeTransition(
          axis: Axis.vertical,
          sizeFactor: animation,
          child: _itemWid(item, index)));

  _buildItem4(item, index, animation) => SlideTransition(
      position: Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
          .animate(animation),
      child: FadeTransition(
          opacity: animation,
          child: SizeTransition(
              axis: Axis.vertical,
              sizeFactor: animation,
              child: _itemWid(item, index))));

  _itemWid(item, index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: Card(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: Row(children: [
                CircleAvatar(backgroundImage: AssetImage(item.avatar)),
                SizedBox(width: 15.0),
                Expanded(child: Text(item.name)),
                GestureDetector(
                    child: Icon(Icons.clear), onTap: () => _removeItem(index))
              ]))));

  _insertItem(index, item) {
    animatedList.insert(index, item);
    key.currentState.insertItem(index);
  }

  _removeItem(index) {
    final item = animatedList.removeAt(index);
    key.currentState.removeItem(
        index, (context, animation) => _buildItem4(item, index, animation));
  }
}

class UserBean {
  String name;
  String avatar;

  UserBean(this.name, this.avatar);
}
