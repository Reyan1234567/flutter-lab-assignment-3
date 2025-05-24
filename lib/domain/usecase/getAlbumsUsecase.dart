import '../entity/albumEntity.dart';
import '../repository/album_repository.dart';

class getAlbumPhotos{
  final AlbumRepository repository;

  getAlbumPhotos(this.repository);

  Future <List<albumPhotoEntity>> getalbumPhotos()async{
    return await repository.getAlbums();
  }
}
