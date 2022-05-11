import 'package:firebase_database/firebase_database.dart';
import 'package:spotify/models/album.dart';
import 'package:spotify/models/artist.dart';
import 'package:spotify/models/genre.dart';

import '../models/playlist.dart';
import '../models/song.dart';
import '../models/user.dart';
import 'helper.dart';

class Database {
  Database();

  // static void setUser(User user) {
  //   FirebaseDatabase.instance.ref('/users').child(user.id).set({
  //     'favoriteAlbumIdList': user.favoriteAlbumIdList,
  //     'favoritePlaylistIdList': user.favoritePlaylistIdList,
  //     'favoriteSongIdList': user.favoriteSongIdList,
  //     'customizedPlaylistIdList': user.customizedPlaylistIdList,
  //     'favoriteArtistIdList': user.favoriteArtistIdList,
  //     'recentPlayedIdList': user.recentPlayedIdList,
  //     'recentSearchIdList': user.recentSearchIdList,
  //   });
  // }
  static void initUser(String id, DateTime creationTime) {
    FirebaseDatabase.instance.ref('/users').child(id).set({
      'createdAt': creationTime.toIso8601String(),
    });
  }

  static void initPlaylist(String name) {
    // FirebaseDatabase.instance.ref('/users').child(id).set({
    //   'createdAt': creationTime.toIso8601String(),
    // });
    FirebaseDatabase.instance
        .ref('/playlists')
        .push()
        .set({'name': name, 'type': 'user'});
  }

  static Future<Song> getSongById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/songs/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    final audioUrl = await getFileFromFirebase('/song/audio/$id.mp3');
    // const audioUrl = '';

    String coverImageUrl;

    if (map['coverImageUrl'] != null) {
      coverImageUrl = map['coverImageUrl'];
    } else {
      coverImageUrl = await getFileFromFirebase('/song/image/$id.jpg');
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
      coverImageUrl = await getFileFromFirebase('/playlist/$id.jpg');
    }

    final playlist = Playlist(
        id: id,
        name: map['name'],
        coverImageUrl: coverImageUrl,
        songIdList: map['songIdList'],
        type: map['type']);

    return playlist;
  }

  static Future<User> getUserById(String id, String name, String? url) async {
    final res = await FirebaseDatabase.instance.ref('/users/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    final user = User(
      id: id,
      name: name,
      coverImageUrl: url ?? 'assets/images/avatar.png',
      favoriteAlbumIdList: map['favoriteAlbumIdList'] ?? [],
      favoritePlaylistIdList: map['favoritePlaylistIdList'] ?? [],
      favoriteSongIdList: map['favoriteSongIdList'] ?? [],
      customizedPlaylistIdList: map['customizedPlaylistIdList'] ?? [],
      favoriteArtistIdList: map['favoriteArtistIdList'] ?? [],
      recentPlayedIdList: map['recentPlayedIdList'] ?? [],
      recentSearchIdList: map['recentSearchIdList'] ?? [],
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
      coverImageUrl = await getFileFromFirebase('/album/$id.jpg');
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

  static Future<List<Playlist>> getSystemPlaylistList() async {
    final res = await FirebaseDatabase.instance.ref('/playlists').get();
    final List<Playlist> playlists = [];
    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      if (value['type'] == 'system') {
        String coverImageUrl;
        if (value['coverImageUrl'] != null) {
          coverImageUrl = value['coverImageUrl'];
        } else {
          coverImageUrl = await getFileFromFirebase('/genre/$key.jpg');
        }
        playlists.add(Playlist(
            id: key,
            name: value['name'],
            coverImageUrl: coverImageUrl,
            songIdList: value['songIdList'],
            type: value['type']));
      }
    });

    return playlists;
  }

  static Future<Artist> getArtistById(String id) async {
    final res = await FirebaseDatabase.instance.ref('/artists/$id').get();

    final map = Map<String, dynamic>.from(res.value as Map);

    String coverImageUrl;

    if (map['coverImageUrl'] != null) {
      coverImageUrl = map['coverImageUrl'];
    } else {
      coverImageUrl = await getFileFromFirebase('/artist/$id.jpg');
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

  static Future<String> getArtistName(String id) async {
    final res = await FirebaseDatabase.instance.ref('/artists/$id/name').get();

    return res.value as String;
  }

  static Future<List<Genre>> getGenres() async {
    final res = await FirebaseDatabase.instance.ref('/genres').get();

    final List<Genre> genres = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      String coverImageUrl;

      if (value['coverImageUrl'] != null) {
        coverImageUrl = value['coverImageUrl'];
      } else {
        coverImageUrl = await getFileFromFirebase('/genre/$key.jpg');
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
        coverImageUrl = await getFileFromFirebase('/album/$key.jpg');
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
        coverImageUrl = await getFileFromFirebase('/artist/$key.jpg');
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

  static Future<List<Song>> getSongs() async {
    final res = await FirebaseDatabase.instance.ref('/songs').get();

    final List<Song> songs = [];

    Map<String, dynamic>.from(res.value as Map).forEach((key, value) async {
      String coverImageUrl;

      if (value['coverImageUrl'] != null) {
        coverImageUrl = value['coverImageUrl'];
      } else {
        coverImageUrl = await getFileFromFirebase('/song/image/$key.jpg');
      }

      songs.add(Song(
        id: key,
        name: value['name'],
        coverImageUrl: coverImageUrl,
        description: value['description'],
        artistIdList: value['artistIdList'],
        albumId: value['albumId'],
        genreIdList: value['genreIdList'],
        audioUrl: '',
      ));
    });

    return songs;
  }
}
