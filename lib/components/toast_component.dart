
import 'package:fluttertoast/fluttertoast.dart';
void showToast(String msg){
  Fluttertoast.cancel();
   Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
       fontSize: 16.0,

  );
}