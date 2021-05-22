import 'package:flutter/material.dart';
import 'package:flutter_app/utils/ace_icons.dart';

class ACEIconPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEIconPageState();
}

List materialData = [
  Icons.android,
  Icons.book,
  Icons.cake,
  Icons.date_range,
  Icons.edit_location,
  Icons.face,
  Icons.gavel,
  Icons.headset,
  Icons.image,
  Icons.eject,
  Icons.keyboard,
  Icons.list,
  Icons.mail_outline,
  Icons.nature,
  Icons.opacity,
  Icons.palette,
  Icons.queue,
  Icons.radio,
  Icons.star,
  Icons.title,
  Icons.update,
  Icons.verified_user,
  Icons.wallpaper,
  Icons.add_box,
  Icons.youtube_searched_for,
  Icons.zoom_in
];

List aceIconData = [
  ACE_ICON.book_story,
  ACE_ICON.book_type,
  ACE_ICON.book_user,
  ACE_ICON.crown,
  ACE_ICON.crown_minus,
  ACE_ICON.crown_plus,
  ACE_ICON.emo_angry,
  ACE_ICON.emo_beer,
  ACE_ICON.emo_coffee,
  ACE_ICON.emo_cry,
  ACE_ICON.emo_devil,
  ACE_ICON.emo_displeased,
  ACE_ICON.emo_grin,
  ACE_ICON.emo_happy,
  ACE_ICON.emo_laugh,
  ACE_ICON.emo_saint,
  ACE_ICON.emo_shoot,
  ACE_ICON.emo_sleep,
  ACE_ICON.emo_squint,
  ACE_ICON.emo_sunglasses,
  ACE_ICON.emo_surprised,
  ACE_ICON.emo_thumbsup,
  ACE_ICON.emo_tongue,
  ACE_ICON.emo_unhappy,
  ACE_ICON.emo_wink,
  ACE_ICON.emo_wink2
];

class _ACEIconPageState extends State<ACEIconPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text('ACE ICON 图表库')), body: _bodyWid());

  _bodyWid() => CustomScrollView(slivers: <Widget>[
        _typeTitleWid('Material Icons'),
        _typeGridWid(materialData),
        _typeTitleWid('ACE Icons'),
        _typeGridWid(aceIconData)
      ]);

  _typeTitleWid(titleStr) {
    return SliverPadding(
        padding: const EdgeInsets.all(10.0),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                    child: Text(titleStr,
                        style: TextStyle(color: Colors.blue, fontSize: 16.0))),
                childCount: 1)));
  }

  _typeGridWid(dataList) {
    return SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0),
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3.0)),
                    child: Center(
                        child: Icon(dataList[index],
                            color: Colors.blue.withOpacity(0.6)))),
                childCount: dataList.length)));
  }
}
