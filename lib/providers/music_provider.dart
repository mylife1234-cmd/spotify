import 'package:flutter/widgets.dart';

import '../models/song.dart';

class MusicProvider extends ChangeNotifier {
  Song? _currentSong = Song('Cảm ơn', 'Đen, Biên', 'assets/images/cam-on.jpg');

  Song? get currentSong => _currentSong;

  bool _playing = false;

  bool get playing => _playing;

  playNewSong(Song newSong) {
    _currentSong = newSong;

    play();

    notifyListeners();
  }

  play() {
    _playing = true;
    notifyListeners();
  }

  pause() {
    _playing = false;
    notifyListeners();
  }
}
