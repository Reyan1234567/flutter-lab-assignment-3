import '../../data/models/album_model.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
  Future<Album> getAlbumById(int id);
}