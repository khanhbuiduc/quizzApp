import 'package:flutter/material.dart';
import 'package:quizz_app/widgets/image_box/image_box_left.dart';
import 'package:quizz_app/widgets/image_box/image_box_right.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 108, 26, 224),
                Color.fromARGB(255, 144, 118, 214)
              ], // Add your desired colors here
            ),
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: ImageBoxLeft(title: "3,274"),
              ),
              SizedBox(
                  child: Text(
                "Quiz",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              )),
              SizedBox(width: 100, child: ImageBoxRight(title: "TinhBC")),
            ],
          ),
        ));
  }
}
