import 'package:lab4/domain/entity/albumEntity.dart';

import '../repository/album_repository.dart';

class getAlbum{
  final AlbumRepository repository;

  getAlbum(this.repository);

  Future<albumEntity> getalbum(int id)async{
    return await repository.getAlbumById(id);
  }
}