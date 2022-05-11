import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/search_all.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/utils/helper.dart';
import 'genre_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final genres = context.watch<DataProvider>().genres;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 45,
                child: TextField(
                  focusNode: _focusNode,
                  onTap: () {
                    _focusNode.unfocus();
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, a1, a2) {
                          return const SearchAll();
                        },
                        transitionsBuilder: (context, a1, a2, child) {
                          return FadeTransition(opacity: a1, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 175),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 125),
                      ),
                    );
                  },
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search for something',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 15),
                child: Text(
                  'Genres',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.75,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                children: genres.map((item) {
                  final image = getImageFromUrl(item.coverImageUrl);

                  return GestureDetector(
                    child: FutureBuilder<PaletteGenerator>(
                      future: PaletteGenerator.fromImageProvider(image),
                      builder: (context, snapshot) {
                        return ClipRRect(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: const Alignment(0.8, 0),
                                colors: snapshot.hasData
                                    ? [
                                        snapshot.data!.dominantColor!.color
                                            .withOpacity(0.8),
                                        snapshot.data!.dominantColor!.color
                                            .withOpacity(0.6)
                                      ]
                                    : [Colors.black, Colors.black12],
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: size.width / 4.5,
                                    ),
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  right: -20,
                                  child: RotationTransition(
                                    turns: const AlwaysStoppedAnimation(
                                      25 / 360,
                                    ),
                                    child: Image(
                                      image: image,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GenrePage(
                            name: item.name,
                            image: image,
                            id: item.id,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
