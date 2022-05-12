import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/playlist.dart';
import '../../models/song.dart';
import '../../pages/music/playlist/playlist_action.dart';
import '../../providers/data_provider.dart';

class PlaylistComponent extends StatelessWidget {
  const PlaylistComponent({
    Key? key,
    required this.songList,
    this.toggleFavorite,
    this.addSong,
    required this.playlist,
  }) : super(key: key);

  final void Function()? toggleFavorite;
  final void Function()? addSong;
  final Playlist playlist;
  final List<Song> songList;
  @override
  Widget build(BuildContext context) {
    final favoritePlaylistList =
        context.watch<DataProvider>().favoritePlaylists;

    final isUserPlayLists = playlist.type == 'user';

    final isFavorite =
        favoritePlaylistList.any((element) => element.id == playlist.id);

    final user = context.watch<DataProvider>().user;

    // final image = getImageFromUrl(user.coverImageUrl);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20, top: 9),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            playlist.name,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 20),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                image: AssetImage('assets/images/logo_spotify.png'),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 7),
              Text(
                isUserPlayLists ? 'My playlist' : 'Spotify',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            if (!isUserPlayLists)
              GestureDetector(
                onTap: toggleFavorite,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    size: 22,
                    color: isFavorite ? Colors.green : Colors.white,
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => PlaylistAction(
                      playlist: playlist,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.more_horiz, size: 22),
            ),
            if (isUserPlayLists && '${user.id}0' != playlist.id)
              GestureDetector(
                onTap: addSong,
                child: const Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
          ],
        )
      ]),
    );
  }
}
