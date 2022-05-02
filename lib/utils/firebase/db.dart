import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotify/models/album.dart';
import 'package:spotify/models/artist.dart';
import 'package:spotify/models/genre.dart';

import '../../models/playlist.dart';
import '../../models/song.dart';
import '../../models/user.dart';

class Database {
  Database();
  static void setUser(User user) {
    FirebaseDatabase.instance.ref('/users/${user.id}').set({
      'coverImageUrl': user.coverImageUrl,
      'recentAlbumIdList': user.recentAlbumIdList,
      'favoriteAlbumIdList': user.favoriteAlbumIdList,
      'recentPlaylistIdList': user.recentPlaylistIdList,
      'favoritePlaylistIdList': user.favoritePlaylistIdList,
      'recentSongIdList': user.recentSongIdList,
      'favoriteSongIdList': user.favoriteSongIdList,
      'customizedPlaylistIdList': user.customizedPlaylistIdList,
      'systemPlaylistIdList': user.systemPlaylistIdList,
      'favoriteArtistIdList': user.favoriteArtistIdList,
    });
  }

  static Future<Song> getSongById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/songs/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    // final audioUrl = await FirebaseStorage.instance
    // .ref('/song/audio/$id.mp3')
    // .getDownloadURL();
    const audioUrl = '';

    String coverImageUrl;

    if (map['coverImageUrl'] != null) {
      coverImageUrl = map['coverImageUrl'];
    } else {
      coverImageUrl = await FirebaseStorage.instance
          .ref('/song/image/$id.jpg')
          .getDownloadURL();
    }

    return Song(
      id: id,
      name: map['name'] ?? '',
      albumId: map['albumId'] ?? '',
      artistIdList: map['artistIdList'] ?? '',
      audioUrl: audioUrl,
      coverImageUrl: coverImageUrl,
      genreIdList: map['genreIdList'],
      description: map['description'],
    );
  }

  static Future<Playlist> getPlaylistById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/playlists/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    String coverImageUrl;

    if (map['coverImageUrl'] != null) {
      coverImageUrl = map['coverImageUrl'];
    } else {
      coverImageUrl = await FirebaseStorage.instance
          .ref('/playlist/$id.jpg')
          .getDownloadURL();
    }

    final playlist = Playlist(
      id: id,
      name: map['name'],
      coverImageUrl: coverImageUrl,
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
      recentAlbumIdList: map['recentAlbumIdList'] ?? [],
      favoriteAlbumIdList: map['favoriteAlbumIdList'] ?? [],
      recentPlaylistIdList: map['recentPlaylistIdList'] ?? [],
      favoritePlaylistIdList: map['favoritePlaylistIdList'] ?? [],
      recentSongIdList: map['recentSongIdList'] ?? [],
      favoriteSongIdList: map['favoriteSongIdList'] ?? [],
      customizedPlaylistIdList: map['customizedPlaylistIdList'] ?? [],
      systemPlaylistIdList: map['systemPlaylistIdList'] ?? [],
      favoriteArtistIdList: map['favoriteArtistIdList'] ?? [],
    );

    return user;
  }

  static Future<Album> getAlbumById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/albums/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    String coverImageUrl;

    if (map['coverImageUrl'] != null) {
      coverImageUrl = map['coverImageUrl'];
    } else {
      coverImageUrl =
          await FirebaseStorage.instance.ref('/album/$id.jpg').getDownloadURL();
    }

    final album = Album(
      id: id,
      artistId: map['artistId'],
      name: map['name'],
      coverImageUrl: coverImageUrl,
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

    String coverImageUrl;

    if (map['coverImageUrl'] != null) {
      coverImageUrl = map['coverImageUrl'];
    } else {
      coverImageUrl = await FirebaseStorage.instance
          .ref('/artist/$id.jpg')
          .getDownloadURL();
    }

    final artist = Artist(
      id: id,
      name: map['name'],
      coverImageUrl: coverImageUrl,
      description: map['description'],
      songIdList: map['songIdList'],
    );

    return artist;
  }

  static Future<List<Genre>> getGenres() async {
    final res = await FirebaseDatabase.instance.ref('/genres').get();

    final List<Genre> genres = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      String coverImageUrl;

      if (value['coverImageUrl'] != null) {
        coverImageUrl = value['coverImageUrl'];
      } else {
        coverImageUrl = await FirebaseStorage.instance
            .ref('/genre/$key.jpg')
            .getDownloadURL();
      }

      genres.add(Genre(
        id: key,
        name: value['name'],
        coverImageUrl: coverImageUrl,
      ));
    });

    return genres;
  }

  static Future<List<Album>> getAlbums() async {
    final res = await FirebaseDatabase.instance.ref('/albums').get();

    final List<Album> albums = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      String coverImageUrl;

      if (value['coverImageUrl'] != null) {
        coverImageUrl = value['coverImageUrl'];
      } else {
        coverImageUrl = await FirebaseStorage.instance
            .ref('/album/$key.jpg')
            .getDownloadURL();
      }

      albums.add(Album(
        id: key,
        artistId: value['artistId'],
        name: value['name'],
        coverImageUrl: coverImageUrl,
        description: value['description'],
        songIdList: value['songIdList'],
      ));
    });

    return albums;
  }

  static Future<List<Artist>> getArtists() async {
    final res = await FirebaseDatabase.instance.ref('/artists').get();

    final List<Artist> artists = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      String coverImageUrl;

      if (value['coverImageUrl'] != null) {
        coverImageUrl = value['coverImageUrl'];
      } else {
        coverImageUrl = await FirebaseStorage.instance
            .ref('/artist/$key.jpg')
            .getDownloadURL();
      }

      artists.add(Artist(
        id: key,
        name: value['name'],
        coverImageUrl: coverImageUrl,
        description: value['description'],
        songIdList: value['songIdList'],
      ));
    });

    return artists;
  }

  static Future<String> getArtistName(String id) async {
    final res = await FirebaseDatabase.instance.ref('/artists/$id/name').get();

    return res.value as String;
  }

  static Future<List<Song>> getSongs() async {
    final res = await FirebaseDatabase.instance.ref('/songs').get();

    final List<Song> songs = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      String coverImageUrl;

      if (value['coverImageUrl'] != null) {
        coverImageUrl = value['coverImageUrl'];
      } else {
        coverImageUrl = await FirebaseStorage.instance
            .ref('/song/image/$key.jpg')
            .getDownloadURL();
      }

      songs.add(Song(
        id: key,
        name: value['name'],
        coverImageUrl: coverImageUrl,
        description: value['description'],
        artistIdList: value['artistIdList'] ,
        albumId: value['albumId'], 
        genreIdList: value['genreIdList'], 
        audioUrl: '',
      ));
    });

    return songs;
  }

}
