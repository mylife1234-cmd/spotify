import 'package:flutter/material.dart';
class AboutDetailPage extends StatefulWidget {
  const AboutDetailPage({Key? key}) : super(key: key);

  @override
  State<AboutDetailPage> createState() => _AboutDetailPageState();
}

class _AboutDetailPageState extends State<AboutDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'About',
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
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: const <Widget>[
                    Expanded(
                      child: Text(
                        'Version',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '1.0.1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                            children: detailList.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              item['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList())),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

final detailList = [
  {
    'title': 'Third-party software',
  },
  {
    'title': 'Show Terms & Condition',
  },
  {
    'title': 'Show Privacy Policy',
  },
];
