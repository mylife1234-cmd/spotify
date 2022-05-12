import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/queue/playing_song.dart';
import 'package:spotify/components/queue/song_in_queue.dart';

import '../../providers/music_provider.dart';
import '../../utils/helper.dart';

class PlaylistQueue extends StatefulWidget {
  const PlaylistQueue({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PlaylistQueueState createState() => _PlaylistQueueState();
}

class _PlaylistQueueState extends State<PlaylistQueue> {
  @override
  Widget build(BuildContext context) {
    final playlist = context.watch<MusicProvider>().currentPlaylist;

    final currentSong = context.watch<MusicProvider>().currentSong!;

    final queue = playlist.map(convertMediaItemToSong).toList();

    final currentIndex = queue.indexWhere((e) => e.name == currentSong.name);

    final remainingQueue = queue.sublist(currentIndex + 1);

    final playlistName = context.watch<MusicProvider>().currentPlaylistName;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          iconSize: 24,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: Text(
          playlistName,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          top: false,
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
                PlayingSongTile(song: currentSong),
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
                  buildDefaultDragHandles: false,
                  itemCount: remainingQueue.length,
                  itemBuilder: (context, i) {
                    final newSong = remainingQueue[i];

                    return GestureDetector(
                      onTap: () {
                        context.read<MusicProvider>().playNewSong(newSong);
                      },
                      key: ValueKey(newSong.id),
                      child: SongInQueue(song: newSong, index: i),
                    );
                  },
                  onReorder: (int oldIndex, int newIndex) async {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }

                    final item = playlist[currentIndex + 1 + oldIndex];

                    await context
                        .read<MusicProvider>()
                        .removeSongFromQueue(convertMediaItemToSong(item));

                    await context
                        .read<MusicProvider>()
                        .insertQueueItem(currentIndex + 1 + newIndex, item);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
