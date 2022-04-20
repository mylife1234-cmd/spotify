import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

import '../main.dart';
import '../models/song.dart';

class MusicProvider extends ChangeNotifier {
  MusicProvider() {
    _initialize();
  }

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

  void _initialize() {
    _initializePlaylist();

    _playlistListener();

    _playbackListener();

    _positionListener();

    _durationListener();

    _currentSongListener();
  }

  void _initializePlaylist() {
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
        _audioHandler
          ..seek(Duration.zero)
          ..pause();
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

  void playNewSong(Song newSong) {
    // _currentSong = newSong;

    // updateColor(newSong);

    final index =
        _currentPlaylist.indexWhere((element) => element.title == newSong.name);

    playWithIndex(index);
  }

  void play() {
    // _playing = true;

    notifyListeners();

    _audioHandler.play();
  }

  void playWithIndex(index) {
    _audioHandler.skipToQueueItem(index);

    _updateSkipButtons();

    play();
  }

  void pause() {
    // _playing = false;

    notifyListeners();

    _audioHandler.pause();
  }

  void updateColor(Song newSong) {
    PaletteGenerator.fromImageProvider(AssetImage(newSong.coverUrl))
        .then((generator) {
      _color = generator.mutedColor!.color;

      notifyListeners();
    });
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;

    notifyListeners();
  }

  void toggleShuffle() {
    _shuffling = !_shuffling;

    notifyListeners();

    if (_shuffling) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  void toggleRepeatMode() {
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

  void insertQueueItem(index, item) {
    _audioHandler.insertQueueItem(index, item);
  }

  void removeQueueItemAt(index) {
    _audioHandler.removeQueueItemAt(index);
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
    'title': 'Quảng Hàn Dao (广寒谣)',
    'desc': 'Y Cách Tái Thính, Bất Kháo Phổ Tổ Hợp',
    'url': 'assets/music/Quang Han Dao - Y Cach Tai Thinh_ Bat Kh.mp3',
    'coverUrl': 'assets/music/quang han dao.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/136/135040.jpg'
  },
  {
    'title': 'Xuy Diệt Tiểu Sơn Hà (吹灭小山河)',
    'desc': 'Quốc Phong Đường, Tư Nam',
    'url': 'assets/music/Xuy Diet Tieu Son Ha - Quoc Phong Duong_.mp3',
    'coverUrl': 'assets/music/xuy diet tieu son ha.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/135/134128.jpg'
  },
  {
    'title': 'Âm Thanh Của Nỗi Nhớ Anh',
    'desc': 'Ngạo Thất Gia',
    'url': 'assets/music/Am Thanh Cua Noi Nho Anh DJ.mp3',
    'coverUrl': 'assets/music/am thanh cua noi nho anh.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/128/127142.jpg'
  },
  {
    'title': 'Gió Lay Nhành Đào (风过谢桃花)',
    'desc': 'Tư Nam, Tịch Âm Xã',
    'url': 'assets/music/Gio Lay Nhanh Dao- Tu Nam Tich Am Xa.mp3',
    'coverUrl': 'assets/music/gio lay nhanh dao.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/139/138222.jpg'
  },
  {
    'title': 'Senbonzakura',
    'desc': 'Lindsey Stirling',
    'url': 'assets/music/Senbonzakura - Lindsey Stirling.mp3',
    'coverUrl': 'assets/music/senbonzakura.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/46/45786.jpg'
  },
  {
    'title': 'Sen Động Dưới Thuyền Cá (莲动下渔舟)',
    'desc': 'Dao Quân',
    'url': 'assets/music/Sen Dong Duoi Thuyen Ca - Dao Quan.mp3',
    'coverUrl': 'assets/music/sen dong duoi thuyen danh ca.jpg',
    'artUrl': 'https://data.chiasenhac.com/data/cover/139/138173.jpg'
  },
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
