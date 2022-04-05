import 'package:flutter/material.dart';
import 'package:spotify/components/library/grid_item.dart';
import 'package:spotify/components/library/list_item.dart';
import 'package:spotify/pages/playlist_view.dart';
import 'artist_view.dart';
import 'package:spotify/components/library/filter_button.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePagetState();
}

class _ProfilePagetState extends State<ProfilePage> {
  List playlists = [
    {
      'title': 'Liked Songs',
      'subtitle': 'Playlist',
      'cover': 'assets/images/favorite.png',
      'type': 'playlist'
    },
    {
      'title': 'Đen',
      'subtitle': 'Artist',
      'cover': 'assets/images/den-vau.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Charlie Puth',
      'subtitle': 'Artist',
      'cover': 'assets/images/charlie-puth.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Billie Eilish',
      'subtitle': 'Artist',
      'cover': 'assets/images/billie-eilish.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Bích Phương',
      'subtitle': 'Artist',
      'cover': 'assets/images/bich-phuong.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Maroon 5',
      'subtitle': 'Artist',
      'cover': 'assets/images/maroon5.jpeg',
      'type': 'artist'
    },
  ];
  List recentSearch = [];
  List searchRecent = [];
  String searchString = "";
  final bool _showAsList = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Icon(Icons.more_vert),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/den-vau.jpeg'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "My Profile",
                  style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: FilterButton(
                    title: "Edit profile",
                    active: false,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "20",
                            style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "12",
                            style: TextStyle(color: Colors.white, fontSize: 13.0,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Follow",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Playlists",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: _showAsList ? _buildListView() : _buildGridView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildListView() {
    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final item = playlists[index];

        return GestureDetector(
          child: ListItem(
            title: item['title']!,
            subtitle: item['subtitle']!,
            coverUrl: item['cover']!,
            isSquareCover: item['type']! == 'playlist',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item['type'] == 'playlist'
                    ? PlaylistView(
                  image: AssetImage(item['cover']),
                  label: item['title'],
                )
                    : ArtistView(
                  image: AssetImage(item['cover']),
                  label: item['title'],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.75,
      children: playlists
          .map(
            (item) => GestureDetector(
          child: GridItem(
            title: item['title']!,
            subtitle: item['subtitle']!,
            coverUrl: item['cover']!,
            isSquareCover: item['type']! == 'playlist',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item['type'] == 'playlist'
                    ? PlaylistView(
                  image: AssetImage(item['cover']),
                  label: item['title'],
                )
                    : ArtistView(
                  image: AssetImage(item['cover']),
                  label: item['title'],
                ),
              ),
            );
          },
        ),
      )
          .toList(),
    );
  }
}
