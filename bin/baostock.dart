import 'package:baostock/baostock.dart' as baostock;

import 'dart:convert';
import 'dart:io';
import 'dart:async';


Future<String> ReadStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    sum += value;
  }
  return sum.toString();
}

void main() async {

  // 泛型定义了我们能向流上推送什么类型的数据。它可以是任何类型！
  // 我们再来看看如何获取最后的结果。
  StreamController controller = StreamController();
//监听这个流的出口，当有data流出时，打印这个data
  StreamSubscription subscription = controller.stream.listen((data) => print("$data"));
  controller.sink.add(123);

  String data = "00.8.80\x0100\x010000000024login\x01anonymous\x01123456\x010\x011635716994\n";
  Socket socket = await Socket.connect("www.baostock.com", 10030);
  // var dataint = utf8.encode(data);
  socket.write(data);
  // await socket.flush();
  Stream stream = socket.cast<List<int>>().transform(utf8.decoder);
  String Result = "";
  await for (var value in stream) {
    print(value);
    Result += value;
  }

  // String _response = await utf8.decoder.bind(socket).join();
  // await socket.close();
  // print(_response) ;
  // String result = await ReadStream(stream);
}
