class User {
  User({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.recentAlbumIdList,
    required this.favoriteAlbumIdList,
    required this.recentPlaylistIdList,
    required this.favoritePlaylistIdList,
    required this.recentSongIdList,
    required this.favoriteSongIdList,
    required this.customizedPlaylistIdList,
    required this.systemPlaylistIdList,
  });

  final String id;
  final String name;
  final String coverImageUrl;
  final List recentAlbumIdList;
  final List favoriteAlbumIdList;
  final List recentPlaylistIdList;
  final List favoritePlaylistIdList;
  final List recentSongIdList;
  final List favoriteSongIdList;
  final List customizedPlaylistIdList;
  final List systemPlaylistIdList;
}
