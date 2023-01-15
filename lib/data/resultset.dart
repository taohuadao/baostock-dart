import 'dart:core';
import 'dart:convert';
import '../common/contants.dart' as cons;
import 'mesageheader.dart' as msgheader;
import '../util/socketutil.dart';

import 'package:hashlib/hashlib.dart' as hashlib;

class ResultData {
  String version = cons.BAOSTOCK_CLIENT_VERSION;
  int msg_type = 0; // ;// # 消息类型
  int msg_body_length = 0;

  // ;// # 消息体
  String method = ""; // ;// # 方法名
  String user_id = ""; //;// # 用户账号
  String error_code = cons.BSERR_NO_LOGIN; // # 错误代码
  String error_msg = ""; // # 错误代码

  int cur_page_num = 1; // # 当前页码
  int per_page_count = cons.BAOSTOCK_PER_PAGE_COUNT; // # 当前页条数
  int cur_row_num = 0; // # 当前页面遍历条数 V0.5.5

  String code = ""; // # 股票代码
  String code_name = ""; // # 股票名称
  List fields = []; // # 指示简称 list
  String start_date = ""; // # 开始日期
  String end_date = ""; // # 结束日期
  String frequency = ""; // # 数据类型
  String adjustflag = ""; // # 复权类型
  List data = []; // # 数据值 list类型

  String msgBody = ""; // # 消息体
  String year = ""; // # 年份
  String yearType = ""; // # 年份类别
  String quarter = ""; // # 季度
  String day = ""; // # 天

  String date = ""; // #查询日期
  // ;// # request_id = 0
  // ;// # serial_id = 0

  ResultData() {
    // """初始化方法"""
  }

  // """ 判断是否还有后续数据
  //    :return: 有数据时返回True，当前页没有数据时向服务器请求下一页；没有数据时返回False
  //     """
  Future<bool> Next() async {
    if (data.length == 0) {
      return false;
    }

    if (cur_row_num < data.length) {
      return true;
    } else {
      // # 当前页没有数据，取下一页数据
      List<String> msg_body_split = msgBody.split(cons.MESSAGE_SPLIT);

      int next_page = cur_page_num + 1;
      msg_body_split[2] = next_page.toString();

      msgBody = msg_body_split.join(cons.MESSAGE_SPLIT);

      String msgHeader = msgheader.to_message_header(msg_type, msgBody.length);

      String head_body = msgHeader + msgBody;
      int crc32str = hashlib.crc32code(head_body, Encoding.getByName('utf-8'));

      // crc32str = zlib.crc32(bytes(head_body, encoding='utf-8'))
      String receiveData = await SocketUtil.getInstance().send_data(head_body + cons.MESSAGE_SPLIT + crc32str.toString());
      if (receiveData.isEmpty) {
        return false;
      }

      msgHeader = receiveData.substring(0, cons.MESSAGE_HEADER_LENGTH);
      msgBody = receiveData.substring(cons.MESSAGE_HEADER_LENGTH);

      List<String> headerArr = msgHeader.split(cons.MESSAGE_SPLIT);
      List<String> bodyArr = msgBody.split(cons.MESSAGE_SPLIT);
      // # data.version = headerArr[0]
      // # self.msg_type = headerArr[1]
      msg_body_length = int.parse(headerArr[2]);

      error_code = bodyArr[0];
      error_msg = bodyArr[1];

      if (cons.BSERR_SUCCESS == error_code) {
        method = bodyArr[2];
        user_id = bodyArr[3];
        cur_page_num = int.parse(bodyArr[4]);
        per_page_count = int.parse(bodyArr[5]);
        setData(bodyArr[6]);
        cur_row_num = 0;

        if (data.length == 0) {
          return false;
        } else {
          return true;
        }
      }
      return false;
    }
  }

  // """
  // 对返回数据进行处理，将string转为list类型
  //       @return: 返回处理后的list类型数据
  // """
  void setData(String receive_data) {
    String data_str = receive_data.trim();
    if (data_str.isEmpty) {
      return;
    }

    dynamic js_data = jsonDecode(data_str);

    data = js_data['record'];
  }
}
