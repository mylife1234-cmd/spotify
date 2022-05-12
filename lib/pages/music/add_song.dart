import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/data_provider.dart';

import '../../components/playlist/song_suggestion.dart';
import '../../models/song.dart';

class AddSong extends StatefulWidget {
  const AddSong({Key? key, required this.id, required this.songList})
      : super(key: key);
  final String id;
  final List<Song> songList;
  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  List playlists = [];
  List searchResult = [];
  bool isSearch = false;
  List<Song> chosenSongs = [];

  @override
  Widget build(BuildContext context) {
    playlists = context.watch<DataProvider>().songs;

    for (final song in widget.songList) {
      playlists.removeWhere((e) => e.id == song.id);
    }

    if (!isSearch) {
      searchResult = playlists..sort((a, b) => a.name.compareTo(b.name));
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 38,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      textAlign: TextAlign.left,
                      onChanged: _runSearch,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        fillColor: const Color.fromRGBO(36, 36, 36, 1),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      cursorColor: const Color(0xff57b660),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop<List<Song>>(context, chosenSongs);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10, right: 10, top: 20),
                child: Text(
                  'Suggested',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: _buildListView(searchResult)),
            ],
          ),
        ),
      ),
    );
  }

  void _runSearch(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        isSearch = false;
      });
    } else {
      playlists.sort((a, b) => a.name.compareTo(b.name));

      final subListOne = playlists
          .where((element) =>
              element.name.toLowerCase().contains(keyword.toLowerCase()) &&
              !element.name.toLowerCase().startsWith(keyword))
          .toList();

      final subListTwo = playlists
          .where((element) => element.name.toLowerCase().startsWith(keyword))
          .toList();

      final results = [...subListTwo, ...subListOne];

      setState(() {
        isSearch = true;
        searchResult = results;
      });
    }
  }

  Widget _buildListView(List list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return SongSuggestion(
          song: item,
          trailing: IconButton(
            onPressed: () {
              context
                  .read<DataProvider>()
                  .addSongToPlaylist(item.id, widget.id);

              setState(() {
                chosenSongs.add(item);
                searchResult = playlists..removeWhere((e) => e.id == item.id);
              });
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        );
      },
    );
  }
}
