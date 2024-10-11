import 'package:flutter/material.dart';
import 'package:quizz_app/widgets/image_box/image_box_left.dart';
import 'package:quizz_app/widgets/image_box/image_box_right.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageHeader extends StatefulWidget {
  HomePageHeader({super.key});

  @override
  State<HomePageHeader> createState() => new _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  int total = 0;
  @override
  void initState() {
    super.initState();
    getLocal();
  }

  getLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    total = int.parse(prefs.getString("total") ?? "0");
  }

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: ImageBoxLeft(title: '$total'),
              ),
              const SizedBox(
                  child: Text(
                "Math Games",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              )),
              const SizedBox(width: 100, child: ImageBoxRight(title: "Guest")),
            ],
          ),
        ));
  }
}
