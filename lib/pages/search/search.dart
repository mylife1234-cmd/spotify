import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/search/genre_card.dart';
import 'package:spotify/components/search/search_field.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/utils/helper.dart';

import 'genre_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

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
              SearchField(),
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
