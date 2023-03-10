// # -*- coding:utf-8 -*-
// """
// 登录登出
// @author: baostock.com
// @group : baostock.com
// @contact: baostock@163.com
// """
// import zlib
// import baostock.util.socketutil as sock
// import baostock.data.resultset as rs
// import baostock.common.contants as cons
// import baostock.data.messageheader as msgheader
// import datetime
// import baostock.common.context as conx

/*
    :param user_id:用户ID
    :param password:密码
    :param options:可选项，00.5.00版本暂未使用
    :return: ResultData()
 */

import '../data/resultset.dart' as rs;
import '../common/contants.dart' as cons;

rs.ResultData Login({user_id='anonymous', password='123456', options=0}){
  rs.ResultData data = rs.ResultData();

  if(user_id == null || user_id.isEmpty){
    print("用户ID不能为空。");
    data.error_code = cons.BSERR_USERNAME_EMPTY;
    data.error_msg = "用户ID不能为空。";
    return data;
  }


  return data;
}



