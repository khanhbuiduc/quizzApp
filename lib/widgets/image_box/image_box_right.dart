import 'package:flutter/material.dart';

class ImageBoxRight extends StatelessWidget {
  const ImageBoxRight({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Stack(
        children: [
          Container(
            height: 30,
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: const Color.fromARGB(255, 69, 3, 161),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            top: 0,
            right: -4,
            width: 40,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 240, 143, 17),
                  width: 2.0,
                ),
                color: const Color.fromARGB(255, 69, 3, 161),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/hot-girl.jpg',
                  width: 20.0,
                  height: 20.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
