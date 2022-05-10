class User {
  User({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.favoriteAlbumIdList,
    required this.favoritePlaylistIdList,
    required this.favoriteSongIdList,
    required this.customizedPlaylistIdList,
    required this.favoriteArtistIdList,
    required this.recentPlayedIdList,
    required this.recentSearchIdList,
  });

  final String id;
  String name;
  String coverImageUrl;
  final List favoriteAlbumIdList;
  final List favoritePlaylistIdList;
  final List favoriteSongIdList;
  final List customizedPlaylistIdList;
  final List favoriteArtistIdList;
  final List recentSearchIdList;
  final List recentPlayedIdList;
}
