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
    _playlistListener();

    _playbackListener();

    _positionListener();

    _durationListener();

    _currentSongListener();
  }

  void clear() {
    _currentSong = null;

    _playing = false;

    _color = const Color(0xff2f2215);
  }

  Future loadPlaylist(List<Song> songList) {
    final mediaItems = songList
        .map(
          (song) => MediaItem(
            id: song.id,
            title: song.name,
            artist: song.description,
            artUri: Uri.parse(song.coverImageUrl),
            extras: {
              'url': song.audioUrl,
              'coverUrl': song.coverImageUrl,
              'artistIdList': song.artistIdList,
              'genreIdList': song.genreIdList
            },
            album: song.albumId,
          ),
        )
        .toList();

    return _audioHandler.addQueueItems(mediaItems);
  }

  void addToPlaylist(Song song) {
    final mediaItem = MediaItem(
      id: song.id,
      title: song.name,
      artist: song.description,
      artUri: Uri.parse(song.coverImageUrl),
      extras: {
        'url': song.audioUrl,
        'coverUrl': song.coverImageUrl,
        'artistIdList': song.artistIdList,
        'genreIdList': song.genreIdList
      },
      album: song.albumId,
    );

    _audioHandler.addQueueItem(mediaItem);
  }

  void clearPlaylist() {
    final List<Future> futures = [];

    for (int i = currentPlaylist.length - 1; i >= 0; i--) {
      futures.add(removeQueueItemAt(i));
    }

    Future.wait(futures);
  }

  void _playlistListener() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        _currentPlaylist = [];
        _currentSong = null;
      } else {
        _currentPlaylist = playlist;
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
          id: mediaItem.id,
          name: mediaItem.title,
          artistIdList: mediaItem.extras!['artistIdList'],
          coverImageUrl: mediaItem.extras!['coverUrl'],
          description: mediaItem.artist!,
          genreIdList: mediaItem.extras!['genreIdList'],
          audioUrl: mediaItem.extras!['url'],
          albumId: mediaItem.album!,
        );
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
    ImageProvider image;

    final url = newSong.coverImageUrl;

    if (url.startsWith('https')) {
      image = NetworkImage(url);
    } else {
      image = AssetImage(url);
    }

    PaletteGenerator.fromImageProvider(image).then((generator) {
      _color = generator.mutedColor!.color;

      notifyListeners();
    });
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

  Future removeQueueItemAt(index) {
    return _audioHandler.removeQueueItemAt(index);
  }
}

class ProgressState {
  ProgressState({required this.current, required this.total});

  final Duration current;
  final Duration total;
}

enum RepeatMode { off, all, one }
