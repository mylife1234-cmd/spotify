import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotify/models/album.dart';
import 'package:spotify/models/artist.dart';
import 'package:spotify/models/genre.dart';

import '../../models/playlist.dart';
import '../../models/song.dart';
import '../../models/user.dart';

class Database {
  final database = FirebaseDatabase.instance;

  final albums = FirebaseDatabase.instance.ref('/albums');

  final artists = FirebaseDatabase.instance.ref('/artists');

  final genres = FirebaseDatabase.instance.ref('/genres');

  final playlists = FirebaseDatabase.instance.ref('/playlists');

  final songs = FirebaseDatabase.instance.ref('/songs');

  final users = FirebaseDatabase.instance.ref('/users');

  static Future<Song> getSongById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/songs/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    final audioUrl = await FirebaseStorage.instance
        .ref('/song/audio/$id.mp3')
        .getDownloadURL();

    final coverImageUrl = await FirebaseStorage.instance
        .ref('/song/image/$id.jpg')
        .getDownloadURL();

    return Song(
      id: id,
      name: map['name'],
      albumId: map['albumId'],
      artistIdList: map['artistIdList'],
      audioUrl: audioUrl,
      coverImageUrl: coverImageUrl,
      genreIdList: map['genreIdList'],
      description: map['description'],
    );
  }

  static Future<Playlist> getPlaylistById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/playlists/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    final playlist = Playlist(
      id: id,
      name: map['name'],
      coverImageUrl: map['coverImageUrl'],
      songIdList: map['songIdList'],
    );

    return playlist;
  }

  static Future<User> getUserById(String id, String name) async {
    final res = await FirebaseDatabase.instance.ref('/users/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    final user = User(
      id: id,
      name: name,
      coverImageUrl: map['coverImageUrl'],
      recentAlbumIdList: map['recentAlbumIdList'],
      favoriteAlbumIdList: map['favoriteAlbumIdList'],
      recentPlaylistIdList: map['recentPlaylistIdList'],
      favoritePlaylistIdList: map['favoritePlaylistIdList'],
      recentSongIdList: map['recentSongIdList'],
      favoriteSongIdList: map['favoriteSongIdList'] ?? [],
      customizedPlaylistIdList: map['customizedPlaylistIdList'] ?? [],
      systemPlaylistIdList: map['systemPlaylistIdList'],
      favoriteArtistIdList: map['favoriteArtistIdList'],
    );

    return user;
  }

  static Future<Album> getAlbumById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/albums/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    final album = Album(
      id: id,
      artistId: map['artistId'],
      name: map['name'],
      coverImageUrl: map['coverImageUrl'],
      description: map['description'],
      songIdList: map['songIdList'],
    );

    return album;
  }

  static Future<List<String>> getPlaylistIdList() async {
    final res = await FirebaseDatabase.instance.ref('/playlists').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    return map.keys.toList();
  }

  static Future<Artist> getArtistById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/artists/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);
    print(res.value);
    final artist = Artist(
      id: id,
      name: map['name'],
      coverImageUrl: map['coverImageUrl'],
      description: map['description'],
      songIdList: map['songIdList'],
    );

    return artist;
  }

  static void setUser(User user) {
    FirebaseDatabase.instance.ref('/users/${user.id}').set(user);
  }

  static Future<List<Genre>> getGenres() async {
    final res = await FirebaseDatabase.instance.ref('/genres').get();

    final List<Genre> genres = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) {
      genres.add(Genre(
        id: key,
        name: value['name'],
        coverImageUrl: value['coverImageUrl'],
      ));
    });

    return genres;
  }

  static Future<List<Album>> getAlbums() async {
    final res = await FirebaseDatabase.instance.ref('/albums').get();

    final List<Album> albums = [];
    final map = Map<String, dynamic>.from(res.value as Map);

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) {
      albums.add(Album(
        id: key,
        artistId: value['artistId'],
        name: value['name'],
        coverImageUrl: value['coverImageUrl'],
        description: value['description'],
        songIdList: value['songIdList'],
      ));
    });

    return albums;
  }

  static Future<List<Artist>> getArtists() async {
    final res = await FirebaseDatabase.instance.ref('/artists').get();

    final List<Artist> artists = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) {
      artists.add(Artist(
        id: key,
        name: value['name'],
        coverImageUrl: value['coverImageUrl'],
        description: value['description'],
        songIdList: value['songIdList'],
      ));
    });

    return artists;
  }
}
