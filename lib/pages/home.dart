import 'package:flutter/material.dart';
import 'package:spotify/components/home/album_card.dart';
import 'package:spotify/components/home/home_header.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    getIt.registerSingleton<BuildContext>(context, instanceName: 'homeContext');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(1),
              ],
            ),
          ),
        ),
        // Xu ly man hinh vuot qua do dao
        SafeArea(
          child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(height: 20),
                const HomeHeader(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recentList.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: AlbumCard(
                          label: item['label']!,
                          image: AssetImage(item['image']!),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 15),

                ...(['Uniquely yours', 'Made for you'].map((e) {
                  final shuffledList = customizedList.sublist(0);

                  shuffledList.shuffle();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 9, bottom: 15),
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: shuffledList
                                .sublist(0, customizedList.length)
                                .map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: AlbumCard(
                                  label: item['label']!,
                                  image: AssetImage(item['image']!),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  );
                }).toList()),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

final recentList = [
  {
    'label': "K/DA",
    'image': "assets/images/home/kda.jpg",
  },
  {
    'label': "Bigcityboi",
    'image': "assets/images/home/big-city-boi.jpg",
  },
  {
    'label': "DNA",
    'image': "assets/images/home/dna.jpg",
  },
  {
    'label': "Latata",
    'image': "assets/images/home/latata.jpg",
  },
  {
    'label': "Chilled",
    'image': "assets/images/home/chilled.jpg",
  },
  {
    'label': "Ái Nộ",
    'image': "assets/images/home/ai-no.jpg",
  },
  {
    'label': "Relax",
    'image': "assets/images/home/album2.jpg",
  },
];

final customizedList = [
  {
    'label': "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
    'image': "assets/images/home/album1.jpg",
  },
  {
    'label': "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
    'image': "assets/images/home/album2.jpg",
  },
  {
    'label': "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
    'image': "assets/images/home/chilled.jpg",
  },
  {
    'label': "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
    'image': "assets/images/home/latata.jpg",
  },
  {
    'label': "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
    'image': "assets/images/home/kda.jpg",
  },
  {
    'label': "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
    'image': "assets/images/home/ai-no.jpg",
  },
  {
    'label': "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
    'image': "assets/images/home/dna.jpg",
  },
];
