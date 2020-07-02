import 'dart:io';
import 'dart:isolate';

String hello(String who, String message) {
  return "Hello, $who, $message";
}

//main() {
//  ReceivePort receivePort = new ReceivePort();
//  sendPort.send(receivePort.sendPort);
//
//  receivePort.listen((msg) {
//    sendPort.send('ECHO: $msg');
//  });
//
//  ReceivePort port = ReceivePort();
//  port.receive((msg, reply) => reply.send(hello(msg[0], msg[1])));
//}

void main(args, SendPort port1) async {
  print("isolate_1 start");
  print("isolate_1 args: $args");

  ReceivePort receivePort = new ReceivePort();
  SendPort port2 = receivePort.sendPort;

  receivePort.listen((message) {
    print("isolate_1 message: $message");
  });

  // 将当前 isolate 中创建的SendPort发送到主 isolate中用于通信
  port1.send([0, port2]);
  // 模拟耗时5秒
  sleep(Duration(seconds: 5));
  port1.send([1, "isolate_1 任务完成"]);

  print("isolate_1 stop");
}
