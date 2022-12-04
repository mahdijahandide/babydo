import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snack {
  createSnack(
      {dynamic title,
      dynamic msg,
      dynamic icon,
      dynamic bgColor,
      dynamic duration,
      dynamic titleColor,
      dynamic msgColor}) {
    return Get.snackbar('', '',
        margin:const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        backgroundColor: bgColor ?? Colors.black,
        duration: Duration(seconds: duration ?? 3),
        titleText: Text(
          '$title',
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: titleColor ?? Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          '$msg',
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: msgColor ?? Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: icon ??
            const Icon(
              Icons.error,
              color: Colors.black,
            ));
  }
}
