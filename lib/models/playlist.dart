class Playlist {
  Playlist({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.songIdList,
  });

  final String id;
  final String name;
  final String coverImageUrl;
  final List songIdList;
}
