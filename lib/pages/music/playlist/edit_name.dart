import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/data_provider.dart';

class EditNamePlaylist extends StatefulWidget {
  const EditNamePlaylist(
      {Key? key, this.editPlaylistName, required this.playlistId})
      : super(key: key);
  final String playlistId;
  final void Function(dynamic)? editPlaylistName;

  @override
  State<EditNamePlaylist> createState() => _EditNamePlaylistState();
}

class _EditNamePlaylistState extends State<EditNamePlaylist> {
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
              highlightColor: Colors.transparent,
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
                'Give your playlist a new name.',
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
                    hintText: 'New name',
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:
                        _newPlaylistName != '' ? Colors.white : Colors.white54,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () {
                  if (_newPlaylistName != '') {
                    context
                        .read<DataProvider>()
                        .editPlaylistName(widget.playlistId, _newPlaylistName);
                    setState(() {
                      _newPlaylistName = '';
                    });
                    Navigator.maybePop(context, _newPlaylistName);
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
