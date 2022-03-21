import 'package:flutter/widgets.dart';

import '../models/song.dart';

class MusicProvider extends ChangeNotifier {
  Song? _currentSong = Song('Cảm ơn', 'Đen, Biên', 'assets/images/cam-on.jpg');

  Song? get currentSong => _currentSong;

  playNewSong(Song newSong) {
    _currentSong = newSong;
    notifyListeners();
  }
}