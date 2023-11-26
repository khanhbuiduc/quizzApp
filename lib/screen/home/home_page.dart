import 'package:flutter/material.dart';
import 'package:quizz_app/screen/home/categories_data.dart';
import 'package:quizz_app/screen/home/home_page_header.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 108, 26, 224),
          flexibleSpace: const SafeArea(child: HomePageHeader()),
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
          child: Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color.fromARGB(255, 108, 26, 224),
                  //     Color.fromARGB(255, 192, 94, 195)
                  //   ],
                  // ),
                  ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      child: const Text("Hi TinhBC,",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ))),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    child: const Text("Choose a category",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    height: MediaQuery.of(context).size.width *
                        0.5 *
                        categoriesList.length *
                        0.5,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                      ),
                      itemCount:
                          categoriesList.length, // Number of items in the grid
                      itemBuilder: (context, index) {
                        // Build each grid item
                        return Container(
                            child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Positioned(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width *
                                    0.15 *
                                    categoriesList.length *
                                    0.32,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 134, 60, 220),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 176, 59, 234)
                                          .withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width *
                                    0.2 *
                                    categoriesList.length *
                                    0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage(categoriesList[index].image),
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
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Category> categoriesList = [
    Category(
        image: "assets/images/yellow-light-bulb.png",
        link: "link-1",
        title: "General"),
    Category(
        image: "assets/images/pink-headphone.png",
        link: "link-1",
        title: "Music"),
    Category(
        image: "assets/images/clapper.png", link: "link-1", title: "Movies"),
    Category(
        image: "assets/images/basketball.png", link: "link-1", title: "Sports"),
    Category(image: "assets/images/tivi.png", link: "link-1", title: "Tv"),
    Category(
        image: "assets/images/switch-handheld-game.png",
        link: "link-1",
        title: "Vi"),
  ];
}
