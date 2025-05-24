abstract class albumEvent{
  albumEvent();
}

class FetchAlbum extends albumEvent{
  final dynamic id;

  FetchAlbum(this.id);
}