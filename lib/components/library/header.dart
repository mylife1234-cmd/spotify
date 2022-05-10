import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/profile.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/utils/helper.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({Key? key, this.handleAdding}) : super(key: key);

  final void Function()? handleAdding;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<DataProvider>().user;

    final image = getImageFromUrl(user.coverImageUrl);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ProfilePage();
          }));
        },
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: image,
              radius: 22,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Your Library',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: handleAdding,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white54,
        ),
      ),
    ]);
  }
}
