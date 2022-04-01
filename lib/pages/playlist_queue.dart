import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/queue/playing_song.dart';
import 'package:spotify/components/queue/song_in_queue.dart';

import '../models/song.dart';
import '../providers/music_provider.dart';

class PlaylistQueue extends StatefulWidget {
  const PlaylistQueue({Key? key, song}) : super(key: key);

  @override
  _PlaylistQueueState createState() => _PlaylistQueueState();
}

class _PlaylistQueueState extends State<PlaylistQueue> {
  final List<Song> _currentPlaylist = songList
      .map((song) => Song(song['title']!, song['desc']!, song['coverUrl']!))
      .toList();

  @override
  Widget build(BuildContext context) {
    var currentSong = context.watch<MusicProvider>().currentSong!;
    int indexOfCurrentSong = _currentPlaylist
        .indexWhere((element) => element.name == currentSong.name);
    // print('name = ' + currentSong.name);
    // print('index = ' + indexOfCurrentSong.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // backgroundColor: Colors.black,
        leading: IconButton(
          iconSize: 30,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
        title: Text(
          "Playlist",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Playing Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PlayingSongTile(song: _currentPlaylist[indexOfCurrentSong]),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Next Song',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ReorderableListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      _currentPlaylist.sublist(indexOfCurrentSong + 1).length,
                  itemBuilder: (context, i) {
                    final newSong =
                        _currentPlaylist.sublist(indexOfCurrentSong + 1)[i];
                    return InkWell(
                      onTap: () async {
                        await context
                            .read<MusicProvider>()
                            .playNewSong(findSong(newSong.name));
                        setState(() {});
                      },
                      key: ValueKey(newSong),
                      child: SongInQueue(song: newSong),
                    );
                  },
                  onReorder: (int oldIndex, int newIndex) async{
                    final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                    setState(() {
                      _currentPlaylist.insert(
                          indexOfCurrentSong + 1 + index,
                          _currentPlaylist
                              .removeAt(indexOfCurrentSong + 1 + oldIndex));
                    });
                    // print('newIndex ' + newIndex.toString()
                    //     + "   oldIndex" + oldIndex.toString());
                    // if (newIndex > oldIndex) newIndex -= 1;
                    // final Song song = _currentPlaylist.removeAt(oldIndex);
                    // _currentPlaylist.insert(newIndex, song);
                  })
            ],
          ),
        ),
      ),
    );
  }
  Song findSong(findName) {
    final currentlyPlayingSong =
        _currentPlaylist.firstWhere(((song) => song.name == findName));
    return currentlyPlayingSong;
  }
}

