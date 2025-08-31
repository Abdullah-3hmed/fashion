import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast({
  required String message,
  required ToastStates state,
}) => Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state: state),
  fontSize: 18.0,
);
