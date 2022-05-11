class Playlist {
  Playlist({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.songIdList,
    required this.type,
  });

  final String id;
  final String name;
  final String coverImageUrl;
  List songIdList;
  final String type;
  void updateSongIdList(String id) {
    songIdList =[...songIdList, id];
  }
}
