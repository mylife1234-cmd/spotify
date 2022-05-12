import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_tile.dart';
import 'package:spotify/components/share/item_info.dart';

import '../../../models/album.dart';
import '../../../providers/data_provider.dart';
import '../../../utils/helper.dart';

class AlbumAction extends StatefulWidget {
  const AlbumAction({Key? key, required this.album}) : super(key: key);
  final Album album;

  @override
  _AlbumActionState createState() => _AlbumActionState();
}

class _AlbumActionState extends State<AlbumAction> {
  Color _color = Colors.black;

  @override
  void initState() {
    super.initState();

    final image = getImageFromUrl(widget.album.coverImageUrl);

    getColorFromImage(image).then((color) {
      if (color != null) {
        setState(() {
          _color = color;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context
        .watch<DataProvider>()
        .favoriteAlbums
        .any((e) => e.id == widget.album.id);

    final listAction = [
      Action(
        'Like',
        Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          size: 22,
          color: isFavorite ? Colors.green : Colors.white,
        ),
        _doActionLike,
      ),
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
                    ]),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 44,
                    ),
                    ItemInfo(item: widget.album),
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
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.chevron_back),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _doActionLike() {
    context.read<DataProvider>().toggleFavoriteAlbum(widget.album);
  }

}

class Action {
  Action(this.title, this.leading, this.onTap);

  final String title;
  final Widget leading;
  final void Function() onTap;
}
