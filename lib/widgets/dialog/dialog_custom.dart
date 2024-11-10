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

void show2024Win(BuildContext context, void Function() restart) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Congratulations you won this game!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Do you want to play again?"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: restart,
                child: Text("Restart"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
