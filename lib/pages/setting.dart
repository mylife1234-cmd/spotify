import 'package:flutter/material.dart';
import '../models/song.dart';
import 'package:spotify/components/setting/setting_info.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  double valueBottom = 0;
  double min = 0;
  double max = 12;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: songList.map((item) {
                    return SettingTile(
                      song: Song(
                          item['title']!, item['desc']!, item['coverUrl']!),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        title: Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          "abc@gamil.com",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                          maxLines: 2,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const Text(
                      'Data Saver',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        title: const Text(
                          "Audio Quality",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: const Text(
                          "Sets your audio quality to low (equivalend to 24kbit/s) and dissable artist",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                          maxLines: 2,
                        ),
                        trailing: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              print("VALUE : $value");
                              isSwitched = value;
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const Text(
                      'Playback',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListTile(
                        title: Text(
                          "Crossfade",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          "Aloow you to crossfade betwwen song",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                          maxLines: 2,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      child: SliderTheme(
                        data: SliderThemeData(
                          thumbColor: Colors.green,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 5),
                          activeTrackColor: Colors.green.shade200,
                          inactiveTrackColor: Colors.grey,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                                child: Text(
                                  "Off",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 90,
                                child: Slider(
                                  value: valueBottom,
                                  min: min,
                                  max: max,
                                  label: valueBottom.round().toString(),
                                  onChanged: (value) =>
                                      setState(() => valueBottom = value),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                                child: Text(
                                  max.round().toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final songList = [
  {
    'title': 'Den Vau',
    'desc': 'View Profile',
    'url': 'assets/music/Quang Han Dao - Y Cach Tai Thinh_ Bat Kh.mp3',
    'coverUrl': 'assets/images/den-vau.jpeg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/136/135040.jpg'
  },
];
bool isSwitched = false;
