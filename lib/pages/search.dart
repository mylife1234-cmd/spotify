import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/search/genre_card.dart';
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

                  return FutureBuilder<PaletteGenerator>(
                    future: PaletteGenerator.fromImageProvider(image),
                    builder: (context, snapshot) {
                      final List<Color> colors = [];

                      if (snapshot.hasData) {
                        final color = snapshot.data!.dominantColor!.color;

                        colors.addAll(
                          [color.withOpacity(0.8), color.withOpacity(0.6)],
                        );
                      } else {
                        colors.addAll([Colors.black, Colors.black12]);
                      }

                      return GestureDetector(
                        child: GenreCard(
                          title: item.name,
                          image: image,
                          colors: colors,
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
