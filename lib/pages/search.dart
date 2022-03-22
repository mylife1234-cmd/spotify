import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: size.width / 4.5,
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
                                ),
                                Positioned(
                                  top: 30,
                                  right: -20,
                                  child: RotationTransition(
                                    turns:
                                        const AlwaysStoppedAnimation(25 / 360),
                                    child: Image.asset(
                                      item['image']!,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 10),
                      child: Text(
                        "Browse All",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      itemCount: listMusic1.length,
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
                        final item1 = listMusic1[index];
                        final colorValues =
                        item1['colors']!.split(', ').map((e) {
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
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: size.width / 4.5,
                                    ),
                                    child: Text(
                                      item1['text']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  right: -20,
                                  child: RotationTransition(
                                    turns:
                                    const AlwaysStoppedAnimation(25 / 360),
                                    child: Image.asset(
                                      item1['image']!,
                                      height: 80,
                                      width: 80,
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
    "colors": '0xFF9C2780, 0xFFE040FB',
  },
  {
    'text': "Bigcityboi",
    'image': "assets/images/home/big-city-boi.jpg",
    "colors": '0xff4caf50, 0xFF69F0AE'
  },
  {
    'text': "DNA",
    'image': "assets/images/home/dna.jpg",
    "colors": '0xFF2196F3, 0xFF448AFF'
  },
  {
    'text': "Latata",
    'image': "assets/images/home/latata.jpg",
    "colors": '0xfff44336, 0xFFff5252'
  },
];
final listMusic1 = [
  {
    'text': "Chilled",
    'image': "assets/images/home/chilled.jpg",
    "colors": '0xff8bca4a, 0xFFB2FF59'
  },
  {
    'text': "Ái Nộ",
    'image': "assets/images/home/ai-no.jpg",
    "colors": '0xff455a64, 0xff455a64'
  },
  {
    'text': "Relax",
    'image': "assets/images/home/album2.jpg",
    "colors": '0xFF9CCC65, 0xFF9CCC65'
  },
  {
    'text': "Latata",
    'image': "assets/images/home/latata.jpg",
    "colors": '0xFFBA68C8, 0xFFBA68C8'
  },

];
