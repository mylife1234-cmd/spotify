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
    recentAlbumIdList: [],
    favoriteAlbumIdList: [],
    recentPlaylistIdList: [],
    favoritePlaylistIdList: [],
    recentSongIdList: [],
    favoriteSongIdList: [],
    customizedPlaylistIdList: [],
    favoriteArtistIdList: [],
  );

  final List<Genre> _genres = [];

  final List<Artist> _artists = [];
  final List<Artist> _favoriteArtists = [];

  final List<Song> _recentSongs = [];
  final List<Song> _favoriteSongs = [];
  final List<Album> _albums = [];
  final List<Album> _recentAlbums = [];
  final List<Album> _favoriteAlbums = [];

  final List<Playlist> _recentPlaylists = [];
  final List<Playlist> _favoritePlaylists = [];
  final List<Playlist> _customizedPlaylists = [];
  final List<Playlist> _systemPlaylists = [];

  User get user => _user;

  List<Genre> get genres => _genres;

  List<Artist> get artists => _artists;

  List<Artist> get favoriteArtists => _favoriteArtists;

  List<Song> get recentSongs => _recentSongs;

  List<Song> get favoriteSongs => _favoriteSongs;

  List<Album> get albums => _albums;

  List<Album> get recentAlbums => _recentAlbums;

  List<Album> get favoriteAlbums => _favoriteAlbums;

  List<Playlist> get recentPlaylists => _recentPlaylists;

  List<Playlist> get favoritePlaylists => _favoritePlaylists;

  List<Playlist> get customizedPlaylists => _customizedPlaylists;

  List<Playlist> get systemPlaylists => _systemPlaylists;

  void clear() {
    _user = User(
      id: '',
      name: '',
      coverImageUrl: '',
      recentAlbumIdList: [],
      favoriteAlbumIdList: [],
      recentPlaylistIdList: [],
      favoritePlaylistIdList: [],
      recentSongIdList: [],
      favoriteSongIdList: [],
      customizedPlaylistIdList: [],
      favoriteArtistIdList: [],
    );

    _genres.clear();

    _artists.clear();
    _favoriteArtists.clear();

    _recentSongs.clear();
    _favoriteSongs.clear();

    _albums.clear();
    _recentAlbums.clear();
    _favoriteAlbums.clear();

    _recentPlaylists.clear();
    _favoritePlaylists.clear();
    _customizedPlaylists.clear();
    _systemPlaylists.clear();
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
    _recentSongs.addAll(songs);

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
    _recentAlbums.addAll(albums);

    notifyListeners();
  }

  void addFavoriteAlbums(List<Album> albums) {
    _favoriteAlbums.addAll(albums);

    notifyListeners();
  }

  void addRecentPlaylists(List<Playlist> playlists) {
    _recentPlaylists.addAll(playlists);

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

  void addSystemPlaylists(List<Playlist> playlists) {
    _systemPlaylists.addAll(playlists);

    notifyListeners();
  }

  final List<Song> _songs = [];

  List<Song> get songs => _songs;

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
  void toggleFavoriteAlbum(Album album){
    if (_favoriteAlbums.any((element) => element.id == album.id)){
      _favoriteAlbums.removeWhere((element) => element.id == album.id);
    }else{
      _favoriteAlbums.add(album);
    }
    notifyListeners();
    FirebaseDatabase.instance.ref('/users/${user.id}').update({
      'favoriteAlbumIdList' : _favoriteAlbums.map<String>((e) => e.id).toList()
    });
  }
  void toggleFavoritePlaylist(Playlist playlist){
    if (_favoritePlaylists.any((element) => element.id == element.id)){
      _favoritePlaylists.removeWhere((element) => element.id == playlist.id);
    }else{
      _favoritePlaylists.add(playlist);
    }
  }
  void toggleFavoriteArtist(Artist artist){
    if (_favoriteArtists.any((element) => element.id == element.id)){
      _favoriteArtists.removeWhere((element) => element.id == artist.id);
    }else{
      _favoriteArtists.add(artist);
    }
  }
}
