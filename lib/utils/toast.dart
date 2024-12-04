import 'package:coin_manager/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void showToast(String message){
    Fluttertoast.showToast(msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: darkCard,
      textColor: background);
  }
}