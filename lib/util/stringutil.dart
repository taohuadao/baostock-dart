
// """
// 字符串方法
// @author: baostock.com
// @group : baostock.com
// @contact: baostock@163.com
// """
import '../common/contants.dart' as cons;

// """在str的左或右添加0
//     :param str:待修改的字符串
//     :param length:总共的长度
//     :param direction:方向，True左，False右
//     :return:
//     """
String add_zero_for_string(content, length, direction){
  String return_str = content;
  if (content.length < length){
    for (int i = 0; i < length - content.length; i++){
      if (direction){
        return_str = "0" + return_str;
      }else{
        return_str = return_str + "0";
      }
    }
  }
  return return_str;
}

// """判断是否是一个有效的日期字符串
//     :param str:
//     :return: 符合格式返回True,
//     """
bool is_valid_date(str){
  if (str.length != 8){
    return false;
  }
  if (str.substring(0, 4).isNotEmpty && str.substring(4, 6).isNotEmpty && str.substring(6, 8).isNotEmpty){
    return true;
  }
  return false;
}

// try:
// datetime.datetime.strptime(str, "%Y-%m-%d")
// return True
// except Exception:
// return False

// """判断是否是一个有效的年日期字符串：yyyy
//     :param str:
//     :return: 符合格式返回True,
//     """
bool is_valid_year_date(str){
  if (str.length != 4){
    return false;
  }
  if (str.substring(0, 4).isNotEmpty){
    return true;
  }
  return false;
}

// try:
// datetime.datetime.strptime(str, "%Y")
// return True
// except Exception:
// return False

// """判断是否是一个有效的年月日期字符串：yyyy-mm
//     :param str:
//     :return: 符合格式返回True,
//     """
bool is_valid_year_month_date(str){
  if (str.length != 6){
    return false;
  }
  if (str.substring(0, 4).isNotEmpty && str.substring(4, 6).isNotEmpty){
    return true;
  }
  return false;
}

// try:
// datetime.datetime.strptime(str, "%Y-%m")
// return True
// except Exception:
// return False

// """根据传入的信息，组织消息头，并返回"""
String organize_msg_body(String str){
  List<String> str_arr = str.split(cons.MESSAGE_SPLIT);
  String msg_body = "" ; //# 返回的消息头
  for(int i = 0; i < str_arr.length; i++){
    if (str_arr[i].isNotEmpty){
      msg_body = msg_body + str_arr[i] + cons.MESSAGE_SPLIT;
    }
  }

  return msg_body.substring(0, msg_body.length - 1);
}

// str_arr = str.split(",")
// msg_body = ""  # 返回的消息头
// for item in str_arr:
// msg_body = msg_body + item.strip() + cons.MESSAGE_SPLIT
// return msg_body[0:len(msg_body) - 1]

// """根据传入的信息，组织消息头，并返回"""
String organize_realtime_msg_body(String str){
  List<String> str_arr = str.split(cons.MESSAGE_SPLIT);
  String msg_body = "" ; //# 返回的消息头
  for(int i = 0; i < str_arr.length; i++){
    if (str_arr[i].isNotEmpty){
      msg_body = msg_body + str_arr[i] + cons.MESSAGE_SPLIT;
    }
  }

  return msg_body.substring(0, msg_body.length - 1);
}

// str_arr = str.split(cons.MESSAGE_SPLIT)
// msg_body = ""  # 返回的消息头
// for item in str_arr:
// msg_body = msg_body + item.strip() + cons.MESSAGE_SPLIT
// return msg_body[0:len(msg_body) - 1]
