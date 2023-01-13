// """
// 获取默认socket
// @author: baostock.com
// @group : baostock.com
// @contact: baostock@163.com
// """

// import time
// import socket
// import threading
// import zlib
// import baostock.common.contants as cons
// import baostock.common.context as context
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import '../common/contants.dart' as cons;

class SocketUtil {
  SocketUtil._();

  // 单例模式固定格式
  static SocketUtil? _instance;

  // 单例模式固定格式
  static SocketUtil getInstance() {
    _instance ??= SocketUtil._();
    return _instance!;
  }

  Socket? _socket;

  // """获取默认socket
  //     :return:
  //     """
  Future<Socket> getSocket() async {
    _socket ??= await Socket.connect(cons.BAOSTOCK_SERVER_IP, cons.BAOSTOCK_SERVER_PORT);
    return _socket!;
  }

  // """发送数据
  //     :param data:
  //     :return:
  //     """
  Future<String> send_data(data) async {
    Socket socket = await getSocket();
    socket.write(data);
    await socket.flush();
    Stream stream = socket.cast<List<int>>().transform(utf8.decoder);
    String receive = "";
    // """接收数据
    await for (var value in stream) {
      receive += value;
      if (receive.endsWith("<![CDATA[]]>\n")) {
        break;
      }
    }

    String headStr = receive.substring(0, cons.MESSAGE_HEADER_LENGTH);
    List<String> headArr = headStr.split(cons.MESSAGE_SPLIT);
    if (headArr.length != 3) {
      throw Exception("head_arr.length != 3");
    }

    if (cons.COMPRESSED_MESSAGE_TYPE_TUPLE.contains(headArr[1])) {
      int headInnerLength = int.parse(headArr[2]);
      String innerBytes = receive.substring(cons.MESSAGE_HEADER_LENGTH, cons.MESSAGE_HEADER_LENGTH + headInnerLength);
      var inflated = zlib.decode(utf8.encode(innerBytes));
      String bodyStr = utf8.decode(inflated);
      return headStr + bodyStr;
    } else {
      return receive;
    }
  }
}

class SocketRealTimeUtil {
  // Socket? socket;
  //
  //
  // String send_real_time_msg(msg) async {
  //   String result = "";
  //   msg = msg + "<![CDATA[]]>"; // # 在消息结尾追加“消息之间的分隔符”
  //   default_socket.send(bytes(msg, encoding = 'utf-8'))
  //
  //
  //   return result;
  // }
}
