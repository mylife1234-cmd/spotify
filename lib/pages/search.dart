import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Search',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.camera_enhance_outlined),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 39,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontFamily: 'SpotifyFont'),
                        decoration: InputDecoration(
                          hintText: 'Search for something',
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search,
                              color: Colors.black, size: 18.0),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your top generes ",
                              style: TextStyle(fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            GridView.builder(
                              itemCount: 8,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    childAspectRatio: 1.76,),
                              shrinkWrap: true,
                              controller:
                                  ScrollController(keepScrollOffset: false),
                              itemBuilder: (BuildContext context, int index) {
                                return GridTile(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment(0.8, 0.0),
                                            colors: [
                                              Colors.red,
                                              Colors.redAccent,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 15, left: 10.0, right: 10.0),
                                              child: const Text(
                                                'Nhạc\nViệt',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(top: 15, left: 10),
                                                child: RotationTransition(
                                                  turns: const AlwaysStoppedAnimation(15 / 360),
                                                  child: Image.asset(
                                                    'assets/images/den-vau.jpeg',
                                                    height: 70,
                                                    width: 70,
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )),
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
    "colors": [
      Colors.red,
      Colors.redAccent,
    ],
  },
  {
    'text': "Bigcityboi",
    'image': "assets/images/home/big-city-boi.jpg",
    "colors": [
      Colors.blue,
      Colors.blueAccent,
    ]
  },
  {
    'text': "DNA",
    'image': "assets/images/home/dna.jpg",
    "colors": [
      Colors.red,
      Colors.redAccent,
    ]
  },
  {
    'text': "Latata",
    'image': "assets/images/home/latata.jpg",
    "colors": [
      Colors.red,
      Colors.redAccent,
    ]
  },
  {
    'text': "Chilled",
    'image': "assets/images/home/chilled.jpg",
    "colors": [
      Colors.red,
      Colors.redAccent,
    ]
  },
  {
    'text': "Ái Nộ",
    'image': "assets/images/home/ai-no.jpg",
    "colors": [
      Colors.red,
      Colors.redAccent,
    ]
  },
  {
    'text': "Relax",
    'image': "assets/images/home/album2.jpg",
    "colors": [
      Colors.red,
      Colors.redAccent,
    ]
  },
];

