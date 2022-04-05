import 'package:flutter/material.dart';
import "package:spotify/pages/setting.dart";
class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Recently Played',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.notifications),
              SizedBox(width: 15),
              Icon(Icons.history),
              SizedBox(width: 15),
              //Icon(Icons.settings,),
              IconButton(onPressed:(){_onSearchButtonPressed(context);} , icon: Icon(Icons.settings,))
            ],
          )
        ],
      ),
    );
  }
}
void _onSearchButtonPressed(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (BuildContext context) {
      //return const SearchPlayList();
      return const SettingsPage();
    }),
  );
}

