import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

dialogCustom(context, {required Widget content}) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 200),
    context: context,
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
    pageBuilder: (BuildContext context, anim1, anim2) {
      return content;
    },
  );
}
