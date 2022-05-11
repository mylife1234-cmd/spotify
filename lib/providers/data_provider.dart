import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

import '../models/album.dart';
import '../models/artist.dart';
import '../models/genre.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import '../models/user.dart';

class DataProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    coverImageUrl: '',
    favoriteAlbumIdList: [],
    favoritePlaylistIdList: [],
    favoriteSongIdList: [],
    customizedPlaylistIdList: [],
    favoriteArtistIdList: [],
    recentPlayedIdList: [],
    recentSearchIdList: [],
  );

  final List<Genre> _genres = [];

  final List<Artist> _artists = [];
  final List<Artist> _favoriteArtists = [];

  final List<Song> _songs = [];
  final List<Song> _favoriteSongs = [];

  final List<Album> _albums = [];
  final List<Album> _favoriteAlbums = [];

  final List<Playlist> _favoritePlaylists = [];
  final List<Playlist> _customizedPlaylists = [];
  final List<Playlist> _systemPlaylists = [];

  final List _recentSearchList = [];
  final List _recentPlayedList = [];

  List get recentPlayedList => _recentPlayedList;

  List get recentSearchList => _recentSearchList;

  List<Song> get songs => _songs;

  User get user => _user;

  List<Genre> get genres => _genres;

  List<Artist> get artists => _artists;

  List<Artist> get favoriteArtists => _favoriteArtists;

  List<Song> get favoriteSongs => _favoriteSongs;

  List<Album> get albums => _albums;

  List<Album> get favoriteAlbums => _favoriteAlbums;

  List<Playlist> get favoritePlaylists => _favoritePlaylists;

  List<Playlist> get customizedPlaylists => _customizedPlaylists;

  List<Playlist> get systemPlaylists => _systemPlaylists;

  void clear() {
    _user = User(
      id: '',
      name: '',
      coverImageUrl: '',
      favoriteAlbumIdList: [],
      favoritePlaylistIdList: [],
      favoriteSongIdList: [],
      customizedPlaylistIdList: [],
      favoriteArtistIdList: [],
      recentSearchIdList: [],
      recentPlayedIdList: [],
    );

    _genres.clear();

    _artists.clear();
    _favoriteArtists.clear();

    _songs.clear();
    _favoriteSongs.clear();

    _albums.clear();
    _favoriteAlbums.clear();

    _favoritePlaylists.clear();
    _customizedPlaylists.clear();
    _systemPlaylists.clear();

    _recentSearchList.clear();
    _recentPlayedList.clear();
  }

  void setUser(User user) {
    _user = user;

    notifyListeners();
  }

  void addGenres(List<Genre> genres) {
    _genres.addAll(genres);

    notifyListeners();
  }

  void addArtists(List<Artist> artists) {
    _artists.addAll(artists);

    notifyListeners();
  }

  void addFavoriteArtists(List<Artist> artists) {
    _favoriteArtists.addAll(artists);

    notifyListeners();
  }

  void addRecentSongs(List<Song> songs) {
    notifyListeners();
  }

  void addFavoriteSongs(List<Song> songs) {
    _favoriteSongs.addAll(songs);

    notifyListeners();
  }

  void addAlbums(List<Album> albums) {
    _albums.addAll(albums);

    notifyListeners();
  }

  void addRecentAlbums(List<Album> albums) {
    notifyListeners();
  }

  void addFavoriteAlbums(List<Album> albums) {
    _favoriteAlbums.addAll(albums);

    notifyListeners();
  }

  void addRecentPlaylists(List<Playlist> playlists) {
    notifyListeners();
  }

  void addFavoritePlaylists(List<Playlist> playlists) {
    _favoritePlaylists.addAll(playlists);

    notifyListeners();
  }

  void addCustomizedPlaylists(List<Playlist> playlists) {
    _customizedPlaylists.addAll(playlists);

    notifyListeners();
  }

  void addRecentSearchList(List list) {
    _recentSearchList.addAll(list);

    notifyListeners();
  }

  void addRecentPlayedList(List list) {
    _recentPlayedList.addAll(list);

    notifyListeners();
  }

  void addSystemPlaylists(List<Playlist> playlists) {
    _systemPlaylists.addAll(playlists);

    notifyListeners();
  }

  void addSongs(List<Song> songs) {
    _songs.addAll(songs);

    notifyListeners();
  }

  void toggleFavoriteSong(Song song) {
    if (_favoriteSongs.any((element) => element.id == song.id)) {
      _favoriteSongs.removeWhere((element) => element.id == song.id);
    } else {
      _favoriteSongs.add(song);
    }

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'favoriteSongIdList': _favoriteSongs.map<String>((e) => e.id).toList()
    });
  }

  void toggleFavoriteAlbum(Album album) {
    if (_favoriteAlbums.any((element) => element.id == album.id)) {
      _favoriteAlbums.removeWhere((element) => element.id == album.id);
    } else {
      _favoriteAlbums.add(album);
    }

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'favoriteAlbumIdList': _favoriteAlbums.map<String>((e) => e.id).toList()
    });
  }

  void toggleFavoritePlaylist(Playlist playlist) {
    if (_favoritePlaylists.any((element) => element.id == playlist.id)) {
      _favoritePlaylists.removeWhere((element) => element.id == playlist.id);
    } else {
      if (playlist.id != user.id) {
        _favoritePlaylists.add(playlist);
      }
    }

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'favoritePlaylistIdList':
          _favoritePlaylists.map<String>((e) => e.id).toList()
    });
  }

  void toggleFavoriteArtist(Artist artist) {
    if (_favoriteArtists.any((element) => element.id == artist.id)) {
      _favoriteArtists.removeWhere((element) => element.id == artist.id);
    } else {
      _favoriteArtists.add(artist);
    }

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'favoriteArtistIdList': _favoriteArtists.map<String>((e) => e.id).toList()
    });
  }

  void addSongToPlaylist(String songId, Playlist playlist) {
    final newPlaylist = _customizedPlaylists
        .firstWhere((element) => element.id == playlist.id)
      ..updateSongIdList(songId);

    FirebaseDatabase.instance
        .ref('/playlists/${playlist.id}')
        .update({'songIdList': newPlaylist.songIdList});

    notifyListeners();
  }

  void deleteFromRecentSearchList(item) {
    _recentSearchList.removeWhere((element) => element.id == item.id);

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'recentSearchIdList': _recentSearchList.map<String>((e) {
        switch (e.runtimeType.toString()) {
          case 'Song':
            return 'song-${e.id}';
          case 'Album':
            return 'album-${e.id}';
          case 'Playlist':
            return 'playlist-${e.id}';
          default:
            return 'artist-${e.id}';
        }
      }).toList()
    });
  }

  void addToRecentSearchList(item) {
    _recentSearchList
      ..removeWhere((element) => element.id == item.id)
      ..insert(0, item);

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'recentSearchIdList': _recentSearchList.map<String>((e) {
        switch (e.runtimeType.toString()) {
          case 'Song':
            return 'song-${e.id}';
          case 'Album':
            return 'album-${e.id}';
          case 'Playlist':
            return 'playlist-${e.id}';
          default:
            return 'artist-${e.id}';
        }
      }).toList()
    });
  }

  void clearRecentSearchList() {
    _recentSearchList.clear();

    notifyListeners();

    FirebaseDatabase.instance
        .ref('/users/${user.id}')
        .update({'recentSearchIdList': []});
  }

  void addToRecentPlayedList(item) {
    _recentPlayedList
      ..removeWhere((element) => element.id == item.id)
      ..insert(0, item);

    if (_recentPlayedList.length > 25) {
      _recentPlayedList.removeAt(_recentPlayedList.length - 1);
    }

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'recentPlayedIdList': _recentPlayedList.map<String>((e) {
        switch (e.runtimeType.toString()) {
          case 'Album':
            return 'album-${e.id}';
          case 'Playlist':
            return 'playlist-${e.id}';
          default:
            return 'artist-${e.id}';
        }
      }).toList()
    });
  }

  void deleteFromPlayedList(item) {
    _recentPlayedList.removeWhere((element) => element.id == item.id);

    notifyListeners();

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'recentPlayedIdList': _recentPlayedList.map<String>((e) {
        switch (e.runtimeType.toString()) {
          case 'Album':
            return 'album-${e.id}';
          case 'Playlist':
            return 'playlist-${e.id}';
          default:
            return 'artist-${e.id}';
        }
      }).toList()
    });
  }

  void clearRecentPlayedList() {
    _recentPlayedList.clear();

    notifyListeners();

    FirebaseDatabase.instance
        .ref('/users/${user.id}')
        .update({'recentPlayedIdList': []});
  }

  void updateUserName(String name) {
    user.name = name;

    notifyListeners();
  }

  void updateUserAvatar(String url) {
    user.coverImageUrl = url;

    notifyListeners();
  }

  void creatNewPlaylist(String playlistName) {
    final Playlist newPlaylist = Playlist(
      id: _user.id.toString() + _customizedPlaylists.length.toString(),
      name: playlistName,
      coverImageUrl: 'assets/images/default-cover.png',
      type: 'user',
      songIdList: [],
    );

    _customizedPlaylists.add(newPlaylist);

    notifyListeners();

    FirebaseDatabase.instance.ref('/playlists').child(newPlaylist.id).set({
      'name': playlistName,
      'type': 'user',
      'coverImageUrl': newPlaylist.coverImageUrl,
    });

    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'customizedPlaylistIdList':
          _customizedPlaylists.map<String>((e) => e.id).toList()
    });
  }

}
