import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_water_button.dart';

class ACEWaterButtonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEWaterButtonState();
}

class _ACEWaterButtonState extends State<ACEWaterButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ACEWaterButton')),
        body: ListView(children: [
          SizedBox(height: 15.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ACEWaterButton(Colors.deepOrange,
                innerIcon: Icon(Icons.settings_voice, color: Colors.white)),
            ACEWaterButton(Colors.deepOrange,
                duration: Duration(milliseconds: 1000),
                innerIcon: Icon(Icons.settings_voice, color: Colors.white)),
          ]),
          SizedBox(height: 15.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ACEWaterButton(Colors.pink,
                innerSize: 56.0,
                innerIcon: Icon(Icons.music_note_rounded, color: Colors.white)),
            ACEWaterButton(Colors.pink,
                innerSize: 56.0,
                duration: Duration(milliseconds: 1000),
                innerIcon: Icon(Icons.music_note_rounded, color: Colors.white))
          ]),
          SizedBox(height: 15.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ACEWaterButton(Colors.green,
                innerSize: 64.0,
                outSize: 80.0,
                innerIcon: Icon(Icons.phone, color: Colors.white)),
            ACEWaterButton(Colors.green,
                innerSize: 64.0,
                outSize: 80.0,
                duration: Duration(milliseconds: 1000),
                innerIcon: Icon(Icons.phone, color: Colors.white))
          ]),
          SizedBox(height: 15.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ACEWaterButton(Colors.blue,
                innerSize: 64.0,
                outSize: 150.0,
                innerIcon: Icon(Icons.missed_video_call_outlined,
                    color: Colors.white)),
            ACEWaterButton(Colors.blue,
                innerSize: 64.0,
                outSize: 150.0,
                duration: Duration(milliseconds: 1000),
                innerIcon:
                    Icon(Icons.missed_video_call_outlined, color: Colors.white))
          ])
        ]));
  }
}
