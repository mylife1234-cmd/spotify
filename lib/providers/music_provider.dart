import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/song.dart';

class MusicProvider extends ChangeNotifier {
  Song? _currentSong = Song('Cảm ơn', 'Đen, Biên', 'assets/images/cam-on.jpg');

  Song? get currentSong => _currentSong;

  bool _playing = false;

  bool get playing => _playing;

  Color _color = const Color(0xff2f2215);

  Color get color => _color;

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  bool _shuffling = false;

  bool get shuffling => _shuffling;

  RepeatMode _repeatMode = RepeatMode.off;

  RepeatMode get repeatMode => _repeatMode;

  playNewSong(Song newSong) {
    _currentSong = newSong;

    play();

    updateColor(newSong);
  }

  play() {
    _playing = true;
    notifyListeners();
  }

  pause() {
    _playing = false;
    notifyListeners();
  }

  updateColor(Song newSong) {
    PaletteGenerator.fromImageProvider(AssetImage(newSong.coverUrl)).then((generator) {
      _color = generator.mutedColor!.color;

      notifyListeners();
    });
  }

  toggleFavorite() {
    _isFavorite = !_isFavorite;

    notifyListeners();
  }

  toggleShuffle() {
    _shuffling = !_shuffling;

    notifyListeners();
  }

  toggleRepeatMode() {
    final currentIndex = RepeatMode.values.indexOf(_repeatMode);

    final next = (currentIndex + 1) % RepeatMode.values.length;

    _repeatMode = RepeatMode.values[next];

    notifyListeners();
  }
}

enum RepeatMode { off, all, one }