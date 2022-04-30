class Album {
  Album({
    required this.id,
    required this.artistId,
    required this.name,
    required this.coverImageUrl,
    required this.description,
    required this.songIdList,
  });

  final String id;
  final String artistId;
  final String name;
  final String coverImageUrl;
  final String description;
  final List songIdList;
}
