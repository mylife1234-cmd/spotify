import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

import '../main.dart';
import '../models/song.dart';

class MusicProvider extends ChangeNotifier {
  Song? _currentSong;

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

  final _audioHandler = getIt<AudioHandler>();

  bool _isFirstSong = true;

  bool get isFirstSong => _isFirstSong;

  bool _isLastSong = false;

  bool get isLastSong => _isLastSong;

  ProgressState _progressState =
      ProgressState(current: Duration.zero, total: Duration.zero);

  ProgressState get progressState => _progressState;

  List<MediaItem> _currentPlaylist = [];

  List<MediaItem> get currentPlaylist => _currentPlaylist;

  MusicProvider() {
    _initialize();
  }

  _initialize() {
    _initializePlaylist();

    _playlistListener();

    _playbackListener();

    _positionListener();

    _durationListener();

    _currentSongListener();
  }

  _initializePlaylist() {
    final mediaItems = songList
        .map(
          (song) => MediaItem(
            id: songList.indexOf(song).toString().padLeft(3, '0'),
            title: song['title']!,
            artist: song['desc'],
            artUri: Uri.parse(song['artUrl']!),
            extras: {'url': song['url'], 'coverUrl': song['coverUrl']},
          ),
        )
        .toList();

    _audioHandler.addQueueItems(mediaItems);
  }

  void _playlistListener() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        _currentPlaylist = [];
        _currentSong = null;
      } else {
        _currentPlaylist = playlist.map((song) => song).toList();
      }

      _updateSkipButtons();
    });
  }

  void _playbackListener() {
    _audioHandler.playbackState.listen((state) {
      if (!state.playing) {
        _playing = false;
      } else if (state.processingState != AudioProcessingState.completed) {
        _playing = true;
      } else {
        // completed
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }

      notifyListeners();
    });
  }

  void _positionListener() {
    AudioService.position.listen((position) {
      final total = _progressState.total;

      _progressState = ProgressState(current: position, total: total);

      notifyListeners();
    });
  }

  void _durationListener() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final current = _progressState.current;

      _progressState = ProgressState(
          current: current, total: mediaItem?.duration ?? Duration.zero);

      notifyListeners();
    });
  }

  void _currentSongListener() {
    _audioHandler.mediaItem.listen((mediaItem) {
      if (mediaItem != null) {
        _currentSong = Song(
            mediaItem.title, mediaItem.artist!, mediaItem.extras!['coverUrl']);
        _updateSkipButtons();

        updateColor(_currentSong!);
      }
    });
  }

  playNewSong(Song newSong) {
    // _currentSong = newSong;

    // updateColor(newSong);

    final index =
        _currentPlaylist.indexWhere((element) => element.title == newSong.name);

    playWithIndex(index);
  }

  play() {
    // _playing = true;

    notifyListeners();

    _audioHandler.play();
  }

  void playWithIndex(index) {
    _audioHandler.skipToQueueItem(index);

    _updateSkipButtons();

    play();
  }

  pause() {
    // _playing = false;

    notifyListeners();

    _audioHandler.pause();
  }

  updateColor(Song newSong) {
    PaletteGenerator.fromImageProvider(AssetImage(newSong.coverUrl))
        .then((generator) {
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

    if (_shuffling) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  toggleRepeatMode() {
    final currentIndex = RepeatMode.values.indexOf(_repeatMode);

    final next = (currentIndex + 1) % RepeatMode.values.length;

    _repeatMode = RepeatMode.values[next];

    // notifyListeners();

    switch (_repeatMode) {
      case RepeatMode.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatMode.all:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
      case RepeatMode.one:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
    }

    _updateSkipButtons();
  }

  void seek(position) {
    _audioHandler.seek(position);
  }

  void skipToNext() {
    if (_repeatMode == RepeatMode.one) {
      _repeatMode = RepeatMode.all;
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
    }

    _audioHandler.skipToNext();

    notifyListeners();
  }

  void skipToPrevious() {
    if (_repeatMode == RepeatMode.one) {
      _repeatMode = RepeatMode.all;
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
    }

    _audioHandler.skipToPrevious();

    notifyListeners();
  }

  @override
  void dispose() {
    _audioHandler.stop();
    super.dispose();
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      _isFirstSong = true;
      _isLastSong = true;
    } else if (repeatMode == RepeatMode.all || repeatMode == RepeatMode.one) {
      _isFirstSong = false;
      _isLastSong = false;
    } else {
      _isFirstSong = playlist.first == mediaItem;
      _isLastSong = playlist.last == mediaItem;
    }

    notifyListeners();
  }
}

class ProgressState {
  ProgressState({required this.current, required this.total});

  final Duration current;
  final Duration total;
}

enum RepeatMode { off, all, one }

final songList = [
  {
    'title': 'Anh Đếch Cần Gì Nhiều Ngoài Em',
    'desc': 'Đen, Vũ',
    'url': 'assets/music/Anh Dech Can Gi Nhieu Ngoai Em - Den_ Vu.mp3',
    'coverUrl': 'assets/music/Anh Dech Can Gi Nhieu Ngoai Em - Den_ Vu.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/98/97369.jpg'
  },
  {
    'title': 'Cảm ơn',
    'desc': 'Đen, Biên',
    'url': 'assets/music/Cam On - Den_ Bien.mp3',
    'coverUrl': 'assets/music/Cam On - Den_ Bien.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/112/111275.jpg'
  },
  {
    'title': 'Cho Tôi Lang Thang',
    'desc': 'Ngọt, Đen',
    'url': 'assets/music/Cho Toi Lang Thang - Ngot_ Den.mp3',
    'coverUrl': 'assets/music/Cho Toi Lang Thang - Ngot_ Den.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/70/69769.jpg'
  },
  {
    'title': 'Đi Về Nhà',
    'desc': 'Đen, JustaTee',
    'url': 'assets/music/Di Ve Nha - Den_ JustaTee.mp3',
    'coverUrl': 'assets/music/Di Ve Nha - Den_ JustaTee.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/133/132896.jpg'
  },
  {
    'title': 'Hai Triệu Năm',
    'desc': 'Đen, Biên',
    'url': 'assets/music/Hai Trieu Nam - Den_ Bien.mp3',
    'coverUrl': 'assets/music/Hai Trieu Nam - Den_ Bien.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/107/106262.jpg'
  },
  {
    'title': 'một triệu like',
    'desc': 'Đen, Thành Đồng',
    'url': 'assets/music/Mot Trieu Like - Den_ Thanh Dong.mp3',
    'coverUrl': 'assets/music/Mot Trieu Like - Den_ Thanh Dong.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/134/133432.jpg'
  },
  {
    'title': 'Tình Đắng Như Ly Cà Phê',
    'desc': 'Nân, Ngơ',
    'url': 'assets/music/Tinh Dang Nhu Ly Ca Phe - Nan_ Ngo.mp3',
    'coverUrl': 'assets/music/Tinh Dang Nhu Ly Ca Phe - Nan_ Ngo.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/110/109024.jpg'
  },
  {
    'title': 'Trời hôm nay nhiều mây cực!',
    'desc': 'Đen',
    'url': 'assets/music/Troi Hom Nay Nhieu May Cuc_ - Den.mp3',
    'coverUrl': 'assets/music/Troi Hom Nay Nhieu May Cuc_ - Den.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/126/125234.jpg'
  },
];
