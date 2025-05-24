abstract class albumEvent{
  albumEvent();
}

class FetchAlbum extends albumEvent{
  final int id;

  FetchAlbum(this.id);
}