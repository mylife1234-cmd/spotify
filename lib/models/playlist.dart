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
  String coverImageUrl;
  List songIdList;
  final String type;

  void addSongToListIdSong(String id) {
    songIdList = [...songIdList, id];
  }

  void deleteSongFromIdList(String id) {
    songIdList  = [...songIdList]..remove(id);
  }

}
