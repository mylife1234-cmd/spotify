import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initAudioService() async {
  return AudioService.init(
    builder: MyAudioHandler.new,
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.int3120.group22.spotify',
      androidNotificationChannelName: 'Spotify',
      androidNotificationOngoing: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler {
  MyAudioHandler() {
    _initialize();
  }

  late AudioPlayer _audioPlayer;

  late ConcatenatingAudioSource _playlist;

  Future _initialize() async {
    _audioPlayer = AudioPlayer();

    _playlist = ConcatenatingAudioSource(children: []);

    try {
      await _audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      debugPrint('Error: $e');
    }

    _notifyPlaybackEvents();

    _durationListener();

    _currentSongListener();

    _sequenceListener();
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audioSource = mediaItems.map(_createAudioSource);
    _playlist.addAll(audioSource.toList());

    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    if (!queue.value.contains(mediaItem)) {
      final audioSource = _createAudioSource(mediaItem);
      _playlist.add(audioSource);

      final newQueue = queue.value..add(mediaItem);
      queue.add(newQueue);
    }
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    _playlist.removeAt(index);

    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    if (!queue.value.contains(mediaItem)) {
      final audioSource = _createAudioSource(mediaItem);
      _playlist.insert(index, audioSource);

      final newQueue = queue.value..insert(index, mediaItem);
      queue.add(newQueue);
    }
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    final String path = mediaItem.extras!['url'];

    return AudioSource.uri(
      path.contains('assets')
          ? Uri.parse('asset:///$path')
          : path.contains('https')
              ? Uri.parse(path)
              : Uri.file(path),
      tag: mediaItem,
    );
  }

  @override
  Future<void> play() => _audioPlayer.play();

  @override
  Future<void> pause() => _audioPlayer.pause();

  @override
  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  @override
  Future<void> skipToNext() async {
    await _audioPlayer.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await _audioPlayer.seekToPrevious();
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) {
      return;
    }

    if (_audioPlayer.shuffleModeEnabled) {
      index = _audioPlayer.shuffleIndices![index];
    }

    _audioPlayer.seek(Duration.zero, index: index);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.all:
        _audioPlayer.setLoopMode(LoopMode.all);
        break;
      case AudioServiceRepeatMode.group:
        break;
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      await _audioPlayer.setShuffleModeEnabled(false);
    } else {
      await _audioPlayer.shuffle();
      await _audioPlayer.setShuffleModeEnabled(true);
    }
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.dispose();
    return super.stop();
  }

  void _notifyPlaybackEvents() {
    _audioPlayer.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _audioPlayer.playing;

      playbackState.add(playbackState.value.copyWith(
        playing: playing,
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext
        ],
        systemActions: const {MediaAction.seek},
        // androidCompactActionIndices: const [0, 1, 2],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_audioPlayer.processingState]!,
        updatePosition: _audioPlayer.position,
        queueIndex: event.currentIndex,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_audioPlayer.loopMode]!,
        shuffleMode: (_audioPlayer.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
      ));
    });
  }

  void _durationListener() {
    _audioPlayer.durationStream.listen((duration) {
      var index = _audioPlayer.currentIndex;
      final newQueue = queue.value;

      if (index == null || newQueue.isEmpty) {
        return;
      }

      if (_audioPlayer.shuffleModeEnabled) {
        index = _audioPlayer.shuffleIndices!.indexOf(index);
      }

      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;

      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  void _currentSongListener() {
    _audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) {
        return;
      }

      if (_audioPlayer.shuffleModeEnabled) {
        index = _audioPlayer.shuffleIndices!.indexOf(index);
      }

      mediaItem.add(playlist[index]);
    });
  }

  void _sequenceListener() {
    _audioPlayer.sequenceStateStream.listen((SequenceState? state) {
      final sequence = state?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) {
        return;
      }

      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }
}
