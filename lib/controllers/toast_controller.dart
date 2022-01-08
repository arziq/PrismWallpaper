import 'package:flutter/material.dart';
import 'package:cloud_toast/cloud_toast.dart';
// import 'package:prism/services/logger.dart';

class ToastController {
  late final CloudToast fToast;

  void init(BuildContext context) {
    try {
      fToast = CloudToast();
      fToast.init(context);
    } catch (e, s) {
      // logger.e(e, e, s);
    }
  }

  void messageToast(String msg, BuildContext context) {
    final Widget toast = Container(
      child: Center(child: Text(msg)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).padding.top + kToolbarHeight + 40,
      decoration: BoxDecoration(
        color: const Color(0xff27ae61),
      ),
    );
    fToast.showToast(
      child: toast,
      positionedToastBuilder: (context, child) => Positioned(
        child: child,
        top: 0,
        left: 0,
      ),
      gravity: ToastPosition.TOP,
      toastDuration: const Duration(seconds: 2),
      fadeDuration: 250,
    );
  }
}
