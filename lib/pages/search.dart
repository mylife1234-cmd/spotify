import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0
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
                      SizedBox(width: 20),
                    ],
                  )
                ],
              ),

            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textAlign: TextAlign.left,
                style: TextStyle(
                    height:0.9,
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'SpotifyFont'),
                decoration: InputDecoration(
                  hintText: 'Search for something',
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color:Colors.black,size: 18.0),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 17.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Your top genres',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                          colors: [
                            Colors.teal,
                            Colors.tealAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Dance/\nElectronic',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15, left: 10),
                                child: new RotationTransition(
                                  turns: new AlwaysStoppedAnimation(15 / 360),
                                  child: Image.asset(
                                    'assets/images/den-vau.jpeg',
                                    height: 70,
                                    width: 70,
                                  ),
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Colors.red,
                              Colors.redAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Pop',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Colors.blue,
                              Colors.blueAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Hip Hop',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          color: Colors.teal[300],
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Pop',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Browse all',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Colors.teal,
                              Colors.tealAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  '2020\nWrapped',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Colors.yellow,
                              Colors.yellowAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Bollywood',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Colors.green,
                              Colors.greenAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Punjabi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Color(0xFFD4AF37),
                              Color(0xFFCFB53B),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Tamil',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Colors.lightBlue,
                              Colors.lightBlueAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Telugu',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 0.0),
                            colors: [
                              Colors.teal,
                              Colors.tealAccent,
                            ],

                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15, left: 10),
                                child: Text(
                                  'Indie',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                  child: new RotationTransition(
                                    turns: new AlwaysStoppedAnimation(15 / 360),
                                    child: Image.asset(
                                      'assets/images/den-vau.jpeg',
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}