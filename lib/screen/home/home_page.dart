import 'package:flutter/material.dart';
import 'package:math_games/screen/home/categories_data.dart';
import 'package:math_games/screen/home/home_page_header.dart';
import 'package:math_games/screen/home/plus_screen.dart';
import 'package:math_games/widgets/2024_game/2024_game.dart';
import 'package:math_games/widgets/connect_box/connect_box.dart';
import 'package:math_games/widgets/dialog/dialog_custom.dart';
import 'package:math_games/widgets/soguko_game/soguko_game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<Category> categoriesList = [
    Category(
        image: "assets/icons/caculations.png",
        link: "link-1",
        title: "",
        function: (context) {
          dialogCustom(context, content: PlusScreen(type: "calculations"));
        }),
    Category(
        image: "assets/icons/sudoku.png",
        link: "link-1",
        title: "",
        function: (context) {
          dialogCustom(context, content: SudokuGameScreen());
        }),
    Category(
        image: "assets/icons/2024.png",
        link: "link-1",
        title: "",
        function: (context) {
          dialogCustom(context, content: Game2024());
        }),
    Category(
      image: "assets/icons/plus.png",
      link: "link-1",
      title: "",
      function: (context) {
        dialogCustom(context, content: PlusScreen(type: "plus"));
      },
    ),
    Category(
      image: "assets/icons/minus.png",
      link: "link-1",
      title: "",
      function: (context) {
        dialogCustom(context, content: PlusScreen(type: "minus"));
      },
    ),
    Category(
        image: "assets/icons/multiplication.png",
        link: "link-1",
        title: "",
        function: (context) {
          dialogCustom(context, content: PlusScreen(type: "multiplication"));
        }),
    Category(
        image: "assets/icons/divide.png",
        link: "link-1",
        title: "",
        function: (context) {
          dialogCustom(context, content: PlusScreen(type: "divide"));
        }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 108, 26, 224),
          flexibleSpace: SafeArea(child: HomePageHeader()),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 108, 26, 224),
              Color.fromARGB(255, 192, 94, 195)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Choose a category",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  height: MediaQuery.of(context).size.height - 150,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 8.0, // Spacing between columns
                      mainAxisSpacing: 8.0, // Spacing between rows
                    ),
                    itemCount: categoriesList.length +
                        2, // Number of items in the grid
                    itemBuilder: (context, index) {
                      if ((index) > categoriesList.length - 1) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.width * 0.5);
                      }
                      // Build each grid item
                      return GestureDetector(
                        onTap: () {
                          categoriesList[index].function(context);
                        },
                        child: Container(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Positioned(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 209, 124, 251)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          categoriesList[index].image),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 18,
                                child: Text(
                                  categoriesList[index].title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
