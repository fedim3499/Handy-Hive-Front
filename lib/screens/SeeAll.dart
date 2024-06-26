// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_front/res/lists.dart';
import 'package:flutter_front/screens/client_home.dart';
import 'package:flutter_front/widgets/text_widget.dart';

import 'Chat.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  var opacity = 0.0;
  bool position = false;
  @override
  void initState() {
    //
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 70),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: upperRow(),
            ),
            AnimatedPositioned(
                top: position ? 60 : 120,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 300),
                child: findPlombier()),
            AnimatedPositioned(
                top: position ? 390 : 450,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          "Plombier à proximité",
                          22,
                          Colors.black,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        TextWidget(
                          "Voir tout",
                          14,
                          Colors.blue.shade900,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: position ? 430 : 500,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity,
                    child: SizedBox(
                      height: 350,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            animator();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            await Navigator.push(
                                context,
                               MaterialPageRoute(
                                  builder: (context) => Chat(
                                      image: images[index],
                                      name: names[index],
                                      specialist: specialties[index]),
                                ));
                            animator();
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: images[index],
                                    backgroundColor: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        names[index],
                                        20,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                        specialties[index],
                                        17,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.navigation_sharp,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget findPlombier() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: opacity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade700,
                    Colors.blue.shade900,
                    Colors.blue.shade900,
                  ])),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 25,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Center(
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/p6.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            "trouver des traceurs!",
                            18,
                            Colors.white,
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                "Utilisez cette fonctionnalité pour trouver un plombier\nle plus proche de chez vous",
                                15,
                                Colors.white,
                                FontWeight.normal,
                                letterSpace: 0,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
              Positioned(
                  top: 115,
                  left: 20,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/map.png'))),
                    ),
                  )),
              const Positioned(
                  top: 15,
                  right: 15,
                  child: Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                    size: 15,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget upperRow() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientHome(),
                    ));
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
          TextWidget("Notre Plombier", 25, Colors.black, FontWeight.bold),
          const Icon(
            Icons.search,
            color: Colors.black,
            size: 25,
          )
        ],
      ),
    );
  }
}
