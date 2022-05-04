import 'dart:async';
import 'dart:io';

import 'package:bulleted_list/bulleted_list.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class StorageDetailPage extends StatefulWidget {
  const StorageDetailPage({Key? key}) : super(key: key);
  @override
  State<StorageDetailPage> createState() => _StorageDetailPageState();
}

class _StorageDetailPageState extends State<StorageDetailPage> {
  double _diskSpace = 0;
  double _freeSpace = 0;
  double _userSpace = 0;
  double _downloadSpace = 0;
  @override
  void initState() {
    super.initState();
    initDiskSpace();
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      print('Cannot get download folder path');
    }
    return directory?.path;
  }

  Future<void> initDiskSpace() async {
    double diskSpace = 0;
    double freeSpace = 0;
    double userSpace = 0;
    double downloadSpace = 0;
    diskSpace = (await DiskSpace.getTotalDiskSpace)!;
    freeSpace = (await DiskSpace.getFreeDiskSpace)!;
    String downloadFolder;
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      print('Cannot get download folder path');
    }
    downloadFolder = (directory?.path)!;
    downloadSpace = (await DiskSpace.getFreeDiskSpaceForPath(downloadFolder))!;
    userSpace = diskSpace - freeSpace;

    setState(() {
      _diskSpace = diskSpace;
      _freeSpace = freeSpace;
      _userSpace = userSpace;
      _downloadSpace = downloadSpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Storage',
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
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 300,
                      height: 10,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 0.75,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                          backgroundColor: Color(0xffD6D6D6),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 150,
                      height: 10,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 1,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          backgroundColor: Color(0xffD6D6D6),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 100,
                      height: 10,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 1,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          backgroundColor: Color(0xffD6D6D6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: const [
                  BulletedList(
                    listItems: [Text('Other app')],
                    bulletColor: Colors.blue,
                  ),
                  BulletedList(
                    listItems: [Text('Download')],
                    bulletColor: Colors.red,
                  ),
                  BulletedList(
                    listItems: [Text('Cache')],
                    bulletColor: Colors.green,
                  ),
                  BulletedList(
                    listItems: [Text('Free')],
                    bulletColor: Colors.grey,
                  ),

                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}

