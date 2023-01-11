import '../common/contants.dart' as cons;
import '../util/stringutil.dart' as strutil;

String to_message_header(msg_type, total_msg_length){
 String return_str = cons.BAOSTOCK_CLIENT_VERSION + cons.MESSAGE_SPLIT + msg_type
  + cons.MESSAGE_SPLIT
  + strutil.add_zero_for_string(total_msg_length, 10, true);
  return return_str;
}


