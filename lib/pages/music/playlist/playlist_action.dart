import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_tile.dart';
import 'package:spotify/components/share/item_info.dart';
import 'package:spotify/pages/music/playlist/edit_name.dart';

import '../../../models/playlist.dart';
import '../../../providers/data_provider.dart';
import '../../../utils/helper.dart';

class PlaylistAction extends StatefulWidget {
  const PlaylistAction({Key? key, required this.playlist}) : super(key: key);
  final Playlist playlist;

  @override
  _PlaylistActionState createState() => _PlaylistActionState();
}

class _PlaylistActionState extends State<PlaylistAction> {
  Color _color = Colors.black;

  @override
  void initState() {
    super.initState();

    final image = getImageFromUrl(widget.playlist.coverImageUrl);

    getColorFromImage(image).then((color) {
      if (color != null) {
        setState(() => _color = color);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context
        .watch<DataProvider>()
        .favoritePlaylists
        .any((e) => e.id == widget.playlist.id);

    final user = context.watch<DataProvider>().user;

    final editable =
        widget.playlist.type == 'user' && widget.playlist.id != '${user.id}0';

    final listAction = [
      if (widget.playlist.type == 'system')
        Action(
          'Like',
          Icon(
            isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_outline_rounded,
            size: 22,
            color: isFavorite ? Colors.green : Colors.white,
          ),
          _doActionLike,
        ),
      if (editable)
        Action(
          'Edit name Playlist',
          const Icon(Icons.edit, size: 22),
          _doActionEdit,
        ),
      if (editable)
        Action(
          'Delete Playlist',
          const Icon(Icons.close, size: 22),
          _doActionDelete,
        )
    ];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _color.withOpacity(0.6),
                    _color.withOpacity(0.5),
                    _color.withOpacity(0.4),
                    _color.withOpacity(0.3),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 44),
                    ItemInfo(item: widget.playlist),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listAction.map((item) {
                        return ActionTile(
                          title: item.title,
                          leading: item.leading,
                          onTap: item.onTap,
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 29,
            child: SafeArea(
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.chevron_back),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _doActionLike() {
    context.read<DataProvider>().toggleFavoritePlaylist(widget.playlist);
  }

  void _doActionEdit() {
    showCupertinoModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return EditNamePlaylist(
          editPlaylistName: (newPlaylistName) {
            setState(() {
              widget.playlist.name = newPlaylistName;
            });
          },
          playlistId: widget.playlist.id,
        );
      },
      duration: const Duration(milliseconds: 250),
    );
  }

  Future<void> _doActionDelete() async {
    final option = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure'),
          content: const Text('Do you want to delete this playlist?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            )
          ],
        );
      },
    );

    if (option) {
      context.read<DataProvider>().deletePlaylist(widget.playlist.id);

      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      Navigator.pop(context);
    }
  }
}

class Action {
  Action(this.title, this.leading, this.onTap);

  final String title;
  final Widget leading;
  final void Function() onTap;
}
