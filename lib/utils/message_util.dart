import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessageUtil {
  static toast(String messageToast) {
    Fluttertoast.showToast(
        msg: messageToast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        textColor: Colors.black.withOpacity(0.8),
        fontSize: 13.0);
  }
}
