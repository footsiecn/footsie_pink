import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showSnackBar(String text, {ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(msg: text, gravity: gravity);
}

void showErrorSnackBar(String text) {
  Fluttertoast.showToast(
      msg: text, backgroundColor: const Color.fromRGBO(255, 85, 85, .7));
}

void cancelSnackBar() {
  Fluttertoast.cancel();
}
