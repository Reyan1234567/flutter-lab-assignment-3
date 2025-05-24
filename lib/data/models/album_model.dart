import '../../domain/entity/albumEntity.dart';

class AlbumPhotoModel extends albumPhotoEntity{
  AlbumPhotoModel(super.albumId, super.id, super.title, super.url);

  factory AlbumPhotoModel.fromJson(Map<String, dynamic> json){
    return AlbumPhotoModel(json['albumId'], json['id'], json['title'], json['url']);
  }
}

class AlbumModel extends albumEntity{
  AlbumModel(super.userId, super.title, super.id);

  factory AlbumModel.fromJson(Map<String, dynamic> json){
    return AlbumModel(json['userId'], json['title'], json['id']);
  }
}