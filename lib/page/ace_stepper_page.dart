import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_stepper.dart';

class ACEStepperPage extends StatefulWidget {
  ACEStepperType type;

  ACEStepperPage({Key key, this.type});

  @override
  _ACEStepperPageState createState() => new _ACEStepperPageState();
}

class _ACEStepperPageState extends State<ACEStepperPage> {
  @override
  Widget build(BuildContext context) {
    switch (_curStep) {
      case 0:
        _curImg = 'images/icon_hzw01.jpg';
        break;
      case 1:
        _curImg = 'images/icon_hzw02.jpg';
        break;
      case 2:
        _curImg = 'images/icon_hzw03.jpg';
        break;
      case 3:
        _curImg = 'images/icon_hzw01.jpg';
        break;
      case 4:
        _curImg = 'images/icon_hzw02.jpg';
        break;
    }
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('ACEStepper Page')),
            body: widget.type == ACEStepperType.horizontal
                ? Column(children: <Widget>[
                    Expanded(child: _aceStepperWid02()),
                    Expanded(child: _aceStepperWid03()),
                    Expanded(child: _aceStepperWid04()),
                    Expanded(child: _aceStepperWid05())
                  ])
                : Container(child: _aceStepperWid06())));
  }

  var _curStep = 0;
  var _curImg = '';

  Widget _aceStepperWid01() {
    return ACEStepper(
      type: ACEStepperType.vertical,
      isCancel: false,
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              width: 100,
              child: Image.asset(_curImg)),
          SizedBox(width: 30, height: 30),
          Column(children: <Widget>[
            FlatButton(
                color: Colors.orangeAccent.withOpacity(0.4),
                onPressed: onStepContinue,
                child: Text('下一步')),
            FlatButton(
                color: Colors.purple.withOpacity(0.4),
                onPressed: onStepCancel,
                child: Text('上一步'))
          ])
        ]);
      },
      currentStep: _curStep,
      onStepTapped: (step) {
        setState(() {
          _curStep = step;
        });
      },
      onStepContinue: () {
        setState(() {
          if (_curStep < 4) {
            _curStep++;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_curStep > 0) {
            _curStep--;
          }
        });
      },
      steps: [
        ACEStep(
            title: Text('标题一'),
            content: Text('内容一'),
            subtitle: Text('副标题一'),
            lineType: LineType.circle,
            iconType: IconType.text,
            circleData: CircleData(),
            isActive: _curStep >= 0 ? true : false,
            toptips: Text('2019-08-08')),
        ACEStep(
            title: Text('标题二'),
            content: Text('内容二'),
            subtitle: Text('副标题二'),
            lineType: LineType.circle,
            iconType: IconType.text,
            circleData: CircleData(),
            isActive: _curStep >= 1 ? true : false,
            toptips: Text('2019-09-18')),
        ACEStep(
            title: Text('标题三'),
            content: Text('内容三'),
            subtitle: Text('副标题三'),
            lineType: LineType.circle,
            iconType: IconType.text,
            circleData: CircleData(),
            isActive: _curStep >= 2 ? true : false,
            toptips: Text('2019-10-01')),
        ACEStep(
            title: Text('标题四'),
            subtitle: Text('副标题四'),
            content: SizedBox.shrink(),
            lineType: LineType.circle,
            iconType: IconType.text,
            isActive: _curStep >= 3 ? true : false,
            circleData: CircleData(),
            toptips: Text('2019-11-25')),
        ACEStep(
            title: Text('标题五'),
            subtitle: Text('副标题五'),
            content: Text('内容五'),
            lineType: LineType.circle,
            isActive: _curStep >= 4 ? true : false,
            circleData: CircleData(),
            iconType: IconType.text,
            toptips: Text('2019-12-05'))
      ],
    );
  }

  Widget _aceStepperWid02() {
    return ACEStepper(
        type: ACEStepperType.horizontal,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Container();
        },
        steps: [
          ACEStep(
              title: Text('5天'),
              lineType: LineType.circle,
              iconType: IconType.text,
              circleData: CircleData(circleText: "50"),
              isActive: true,
              toptips: Text('2019-08-08')),
          ACEStep(
              title: Text('10天'),
              lineType: LineType.circle,
              iconType: IconType.text,
              circleData: CircleData(circleText: "100"),
              isActive: true,
              toptips: Text('继续坚持哦')),
          ACEStep(
              title: Text('20天'),
              lineType: LineType.circle,
              iconType: IconType.text,
              isActive: false,
              circleData: CircleData(circleText: "200")),
          ACEStep(
              title: Text('30天'),
              subtitle: Text('超值大礼包'),
              lineType: LineType.circle,
              iconType: IconType.ass_url,
              isActive: true,
              circleData: CircleData(circleAssUrl: 'images/icon_vip.png'),
              toptips: Text('VIP 赠送'))
        ]);
  }

  Widget _aceStepperWid03() {
    return ACEStepper(
        type: ACEStepperType.horizontal,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Container();
        },
        themeData: ACEStepThemeData(
            lineColor: Colors.green,
            circleActiveColor: Colors.green,
            contentActiveColor: Colors.green),
        steps: [
          ACEStep(
              title: Text('一级标题'),
              subtitle: Text('二级标题'),
              circleData: CircleData(circleText: '新'),
              isActive: true,
              toptips: Text('顶部 Tips', style: TextStyle(color: Colors.green))),
          ACEStep(
              title: Text('10天'),
              circleData: CircleData(circleText: '年'),
              isActive: true),
          ACEStep(
              title: Text('20天'),
              isActive: true,
              circleData: CircleData(circleText: '快')),
          ACEStep(
              title: Text('30天'),
              isActive: true,
              circleData: CircleData(circleText: '乐'))
        ]);
  }

  Widget _aceStepperWid04() {
    return ACEStepper(
        type: ACEStepperType.horizontal,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Container();
        },
        themeData: ACEStepThemeData(
            lineColor: Colors.orange,
            circleActiveColor: Colors.orange,
            contentActiveColor: Colors.orange),
        steps: [
          ACEStep(
              title: Text('5天'),
              iconType: IconType.ass_url,
              circleData: CircleData(circleAssUrl: 'images/icon_coins.png'),
              isActive: true),
          ACEStep(
              title: Text('一级标题'),
              subtitle: Text('二级标题'),
              iconType: IconType.ass_url,
              circleData: CircleData(circleAssUrl: 'images/icon_vip.png'),
              isActive: false,
              toptips: Text('顶部 Tips', style: TextStyle(color: Colors.grey))),
          ACEStep(
              title: Text('20天'),
              iconType: IconType.icon,
              circleData: CircleData(circleIcon: Icons.android),
              isActive: true),
          ACEStep(
              title: Text('30天'),
              iconType: IconType.net_url,
              circleData: CircleData(
                  circleNetUrl:
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575609869646&di=497ef407b501b95d80765bdd27b80bdc&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01c9505541bb22000001a64b457752.jpg'))
        ]);
  }

  Widget _aceStepperWid05() {
    return ACEStepper(
        type: ACEStepperType.horizontal,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Container();
        },
        themeData: ACEStepThemeData(
            lineColor: Colors.deepPurple,
            circleActiveColor: Colors.deepPurple,
            contentActiveColor: Colors.deepPurple),
        steps: [
          ACEStep(
              title: Text('5天'),
              circleData: CircleData(),
              isActive: true,
              lineType: LineType.circle),
          ACEStep(
              title: Text('10天'),
              iconType: IconType.ass_url,
              circleData: CircleData(circleAssUrl: 'images/icon_vip.png'),
              isActive: true,
              lineType: LineType.circle),
          ACEStep(
              title: Text('20天', style: TextStyle(color: Colors.deepPurple)),
              subtitle:
                  Text('还差10天', style: TextStyle(color: Colors.deepPurple)),
              toptips: Text('加油！', style: TextStyle(color: Colors.deepPurple)),
              iconType: IconType.icon,
              lineType: LineType.circle,
              circleData: CircleData(circleIcon: Icons.android),
              isActive: true),
          ACEStep(
              title: Text('30天'),
              iconType: IconType.net_url,
              lineType: LineType.circle,
              circleData: CircleData(
                  circleNetUrl:
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575609869646&di=497ef407b501b95d80765bdd27b80bdc&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01c9505541bb22000001a64b457752.jpg')),
          ACEStep(
              title: Text('45天'),
              circleData: CircleData(),
              lineType: LineType.circle),
          ACEStep(
              title: Text('60天'),
              circleData: CircleData(),
              lineType: LineType.circle)
        ]);
  }

  Widget _aceStepperWid06() {
    return ACEStepper(
      type: ACEStepperType.vertical,
      isAllContent: true,
      themeData: ACEStepThemeData(lineColor: Colors.grey),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Container();
      },
      steps: [
        ACEStep(
            title: _titleWid('已签收', Colors.black, 16.0),
            content: _titleWid(
                '【北京市】已签收，签收人是快递小箱，如有问题求购联系vip专属电话，随时为您解决问题，轻骑只为佳人笑，给个五星好不好。'
                '\n【请在评价快递员处帮忙点亮五颗小星星】\n期待再次为您服务！',
                Colors.black),
            lineType: LineType.circle,
            iconType: IconType.icon,
            circleData: CircleData(
                circleAssUrl: 'images/icon_sign.png',
                circleIcon: Icons.playlist_add_check),
            isActive: true,
            toptips: _topTipsWid('12-03', '10:30', Colors.black)),
        ACEStep(
            title: _titleWid('温馨提示中', null, 15.0),
            content: _titleWid('亲，包裹将在您可接收的时间尽快为您送达。'),
            lineType: LineType.circle,
            iconType: IconType.icon,
            circleData: CircleData(circleIcon: Icons.feedback),
            toptips: _topTipsWid('12-02', '12:38')),
        ACEStep(
            title: _titleWid('派送中', null, 15.0),
            content: _titleWid('【北京市】北京朝阳区一部派送员：孙悟空当前正在为您派件'),
            lineType: LineType.circle,
            iconType: IconType.icon,
            circleData: CircleData(circleIcon: Icons.person),
            toptips: _topTipsWid('12-01', '14:32')),
        ACEStep(
            title: _titleWid('运输中', null, 15.0),
            content: _titleWid('【北京市】快件已到达 北京朝阳区一部'),
            lineType: LineType.circle,
            iconType: IconType.ass_url,
            circleData: CircleData(circleAssUrl: 'images/icon_transport.png'),
            toptips: _topTipsWid('11-30', '02:38')),
        ACEStep(
            title: _titleWid('运输中', null, 15.0),
            content: _titleWid('【北京市】快件已到达 北京京顺转运中心'),
            lineType: LineType.circle,
            iconType: IconType.ass_url,
            circleData: CircleData(circleAssUrl: 'images/icon_transport.png'),
            toptips: _topTipsWid('11-29', '12:38')),
        ACEStep(
            title: _titleWid('运输中', null, 15.0),
            content: _titleWid('【广州市】快件已到达 广州运转中心'),
            lineType: LineType.circle,
            iconType: IconType.ass_url,
            circleData: CircleData(circleAssUrl: 'images/icon_transport.png'),
            toptips: _topTipsWid('11-28', '03:50')),
        ACEStep(
            title: _titleWid('已揽件', null, 15.0),
            content: _titleWid('【广州市】您的包裹已由物流公司揽收'),
            lineType: LineType.circle,
            iconType: IconType.ass_url,
            circleData: CircleData(circleAssUrl: 'images/icon_send.png'),
            toptips: _topTipsWid('11-26', '12:58')),
        ACEStep(
            title: _titleWid('已发货', null, 15.0),
            content: _titleWid('包裹正在等待揽收'),
            lineType: LineType.circle,
            iconType: IconType.ass_url,
            circleData: CircleData(circleAssUrl: 'images/icon_package.png'),
            toptips: _topTipsWid('11-25', '23:58'))
      ],
    );
  }

  Widget _topTipsWid(time, sectime, [Color color]) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: time,
            style: TextStyle(fontSize: 14.0, color: color ?? Colors.grey),
            children: <TextSpan>[
              TextSpan(
                  text: '\n${sectime}',
                  style: TextStyle(fontSize: 12.0, color: color ?? Colors.grey))
            ]));
  }

  Widget _titleWid(text, [Color color, double size]) {
    return Text(text,
        style: TextStyle(color: color ?? Colors.grey, fontSize: size ?? 14.0));
  }
}
