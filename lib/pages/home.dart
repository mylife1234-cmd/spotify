import 'package:flutter/material.dart';
import 'package:spotify/components/home/album_card.dart';
import 'package:spotify/components/home/song_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 17, top: 24.0, right: 17.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Recently Played',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.notifications),
                          SizedBox(width: 15),
                          Icon(Icons.history),
                          SizedBox(width: 15),
                          Icon(Icons.settings),
                        ],
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AlbumCard(
                        label: "K/DA",
                        image: AssetImage('assets/images/home/kda.jpg'),
                      ),
                      SizedBox(width: 15),
                      AlbumCard(
                        label: "Bigcityboi",
                        image:
                            AssetImage('assets/images/home/big-city-boi.jpg'),
                      ),
                      SizedBox(width: 15),
                      AlbumCard(
                        label: "DNA",
                        image: AssetImage('assets/images/home/dna.jpg'),
                      ),
                      SizedBox(width: 15),
                      AlbumCard(
                        label: "Latata",
                        image: AssetImage('assets/images/home/latata.jpg'),
                      ),
                      SizedBox(width: 15),
                      AlbumCard(
                        label: "Chilled",
                        image: AssetImage('assets/images/home/chilled.jpg'),
                      ),
                      SizedBox(width: 15),
                      AlbumCard(
                        label: "Ái Nộ",
                        image: AssetImage('assets/images/home/ai-no.jpg'),
                      ),
                      SizedBox(width: 15),
                      AlbumCard(
                        label: "Relax",
                        image: AssetImage('assets/images/home/album2.jpg'),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(
                      left: 17, top: 24.0, right: 17.0, bottom: 15.0),
                  child: Text("Uniquely yours",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),

                Padding(
                    padding: const EdgeInsets.only(
                        left: 17, top: 0.0, right: 17.0, bottom: 15.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: const [
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/album1.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/album2.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/chilled.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/latata.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/kda.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/ai-no.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/dna.jpg'),
                          ),
                        ],
                      ),
                    )),

                const Padding(
                  padding: EdgeInsets.only(
                      left: 17, top: 9.0, right: 17.0, bottom: 15.0),
                  child: Text("Made for you",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),

                Padding(
                    padding: const EdgeInsets.only(
                        left: 17, top: 0.0, right: 17.0, bottom: 20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: const [
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/album2.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/chilled.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/latata.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/kda.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/album1.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/ai-no.jpg'),
                          ),
                          SizedBox(width: 15),
                          AlbumCard(
                            label:
                                "Ed Sheeran, Big Sean, Juice WRLD, Post Malone",
                            image: AssetImage('assets/images/home/dna.jpg'),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// class RowAlbumCard extends StatelessWidget {
//   final String label;
//   final ImageProvider image;

//   const RowAlbumCard({
//     Key? key,
//     required this.label,
//     required this.image,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Image(image: image, width: 120, height: 120, fit: BoxFit.cover),
//         const SizedBox(height: 12),
//         Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
//       ],
//     );
//   }
// }
