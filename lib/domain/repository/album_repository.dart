import '../../data/models/album_model.dart';
import '../entity/albumEntity.dart';

abstract class AlbumRepository {
  Future<List<albumPhotoEntity>> getAlbums();
  Future<albumEntity> getAlbumById(int id);
}