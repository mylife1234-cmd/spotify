import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistCreationPage extends StatefulWidget {
  const PlaylistCreationPage({Key? key, this.handlePlaylistCreation})
      : super(key: key);

  final void Function(dynamic)? handlePlaylistCreation;

  @override
  State<PlaylistCreationPage> createState() => _PlaylistCreationPageState();
}

class _PlaylistCreationPageState extends State<PlaylistCreationPage> {
  String _newPlaylistName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Stack(
        children: [
          Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Give your playlist a name.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 50,
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                  onChanged: (value) => setState(() {
                    _newPlaylistName = value;
                  }),
                  decoration: const InputDecoration(
                    hintText: 'Playlist name',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                child: Container(
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: _newPlaylistName != '' ? Colors.white : Colors.white54,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onTap: () {
                  if (_newPlaylistName != '') {
                    widget.handlePlaylistCreation!({
                      'title': _newPlaylistName,
                      'subtitle': 'Playlist',
                      'cover': 'assets/images/default-cover.png',
                      'type': 'playlist'
                    });
                    setState(() {
                      _newPlaylistName = '';
                    });
                    Navigator.maybePop(context);
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
