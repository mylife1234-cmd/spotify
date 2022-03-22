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
}
