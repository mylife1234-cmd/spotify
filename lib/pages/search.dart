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
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0
                ),
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
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'SpotifyFont'),
                  decoration: InputDecoration(
                    hintText: 'Search for something',
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black),
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search, color:Colors.black,size: 18.0),
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 17.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Your top genres',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.teal,
                            Colors.tealAccent,
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
                              'Dance/\nElectronic',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 15, left: 10.0),
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

                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
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
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.blue,
                            Colors.blueAccent,
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
                              'Hip\nHop',
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
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.teal,
                            Colors.tealAccent,
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
                              'Pop',
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
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Browse all',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.teal,
                            Colors.tealAccent,
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
                              '2020\nWarp',
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
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.yellow,
                            Colors.yellowAccent,
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
                              'Nhạc\nẤn Độ',
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
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.green,
                            Colors.greenAccent,
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
                              'Nhạc/\nChâu Âu',
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
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Color(0xFFD4AF37),
                            Color(0xFFCFB53B),
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
                              'Tamil',
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
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.lightBlue,
                            Colors.lightBlueAccent,
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
                              'Podcast\n Việt',
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
                  ClipRRect(
                    child: Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.teal,
                            Colors.tealAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, left: 10.0, right: 10.0),
                            child: const Text(
                              'Indie',
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
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),

    );
  }
}