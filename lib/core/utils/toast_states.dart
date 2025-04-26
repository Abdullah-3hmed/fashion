import 'package:flutter/material.dart';

enum ToastStates { success, error, warning }

Color chooseToastColor({required ToastStates state}) {
  switch (state) {
    case ToastStates.success:
      return Colors.green;

    case ToastStates.error:
      return Colors.red;

    case ToastStates.warning:
      return Colors.amberAccent;
  }
}
