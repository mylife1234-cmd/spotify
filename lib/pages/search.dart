import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.camera_alt_outlined, size: 26)
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for something',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Your top genres",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      itemCount: listMusic.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.75,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      itemBuilder: (BuildContext context, int index) {
                        final item = listMusic[index];

                        final colorValues =
                            item['colors']!.split(', ').map((e) {
                          return int.parse(e);
                        });

                        return ClipRRect(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: const Alignment(0.8, 0.0),
                                colors:
                                    colorValues.map((e) => Color(e)).toList(),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 15,
                                    left: 10.0,
                                    right: 10.0,
                                  ),
                                  child: Text(
                                    item['text']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 15,
                                    left: 10,
                                  ),
                                  child: RotationTransition(
                                    turns:
                                        const AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      item['image']!,
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final listMusic = [
  {
    'text': "K/DA",
    'image': "assets/images/home/kda.jpg",
    "colors": '0xFFD4AF37, 0xFFCFB53B',
  },
  {
    'text': "Bigcityboi",
    'image': "assets/images/home/big-city-boi.jpg",
    "colors": '0xff031cd7, 0xFFCFB53B'
  },
  {
    'text': "DNA",
    'image': "assets/images/home/dna.jpg",
    "colors": '0xFFD4AF37, 0xFFCFB53B'
  },
  {
    'text': "Latata",
    'image': "assets/images/home/latata.jpg",
    "colors": '0xff031cd7, 0xFFCFB53B'
  },
  {
    'text': "Chilled",
    'image': "assets/images/home/chilled.jpg",
    "colors": '0xFFD4AF37, 0xFFCFB53B'
  },
  {
    'text': "Ái Nộ",
    'image': "assets/images/home/ai-no.jpg",
    "colors": '0xff031cd7, 0xFFCFB53B'
  },
  {
    'text': "Relax",
    'image': "assets/images/home/album2.jpg",
    "colors": '0xff031cd7, 0xFFCFB53B'
  },
];
