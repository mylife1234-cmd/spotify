class Song {
  Song({
    required this.id,
    required this.name,
    required this.albumId,
    required this.artistIdList,
    required this.audioUrl,
    required this.coverImageUrl,
    required this.genreIdList,
    required this.description,
  });

  final String id;
  final String name;
  final String albumId;
  final List artistIdList;
  String audioUrl;
  final String coverImageUrl;
  final List genreIdList;
  final String description;
}
