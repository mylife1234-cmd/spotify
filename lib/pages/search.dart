import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 10.0
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
      SizedBox(height: 10,),
      Container(
              height: 38,
        padding: const EdgeInsets.only( left: 15.0, right: 10.0
        ),
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
            SizedBox(height: 10,),
            smalltile(context,"Tamil  ",Colors.red,"English",Colors.green,"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
            SizedBox(height: 10,),
            smalltile(context,"Punjabi",Colors.orange,"English",Colors.yellow,"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
            SizedBox(height: 10,),
            smalltile(context,"Telugu",Colors.purple,"English",Colors.blueAccent,"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
            SizedBox(height: 10,),
            smalltile(context,"Tamil",Colors.red[200],"English",Colors.green[800],"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
            SizedBox(height: 10,),
            smalltile(context,"Tamil  ",Colors.red,"pop",Colors.green,"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
            SizedBox(height: 10,),
            smalltile(context,"Punjabi",Colors.orange,"English",Colors.yellow,"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
            SizedBox(height: 10,),
            smalltile(context,"Telugu",Colors.purple,"English",Colors.blueAccent,"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
            SizedBox(height: 10,),
            smalltile(context,"Tamil",Colors.red[200],"English",Colors.green[800],"assets/images/den-vau.jpeg","assets/images/den-vau.jpeg"),
          ],
        ),
      ),
    );
  }

  Row smalltile(BuildContext context,String text,final clrs,String text2,final clrs2,String imgurl1,String imgurl2) {
    return Row(
      children:<Widget> [
        Padding(padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),),
        ClipRRect(
          child: Container(
            height: 90.0,
            width: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: clrs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 15, left: 10.0, right: 10.0),
                  child: Text(text,
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
                        imgurl1,
                        height: 60,
                        width: 70,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),),
        ClipRRect(
          child: Container(
            height: 90.0,
            width: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: clrs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 15, left: 10.0, right: 10.0),
                  child: Text(text,
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
                        imgurl1,
                        height: 60,
                        width: 70,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}