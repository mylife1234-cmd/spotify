class Artist {
  Artist({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.description,
    required this.songIdList,
  });

  final String id;
  final String name;
  final String coverImageUrl;
  final String description;
  final List songIdList;
}
