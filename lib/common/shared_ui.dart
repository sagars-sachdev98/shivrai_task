import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SharedUi {
  InputDecoration sharedDecoration(
      {required String hintText, required String labelText}) {
    return InputDecoration(
        labelText: " " + labelText,
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        hintText: " " + hintText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
        ));
  }

  showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : const Color(0xff1ad1cc),
        textColor: Colors.white,
        webBgColor: isError ? "880808" : "1ad1cc",
        fontSize: 16.0);
  }

  validation(dynamic value, String message) {
    if (value == null || value == '') {
      return message;
    } else {
      return null;
    }
  }
}
