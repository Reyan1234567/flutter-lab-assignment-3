import 'package:lab4/domain/entity/albumEntity.dart';

abstract class PhotoState{
  const PhotoState();
}

class PhotosInitial extends PhotoState{}

class PhotosLoading extends PhotoState{}

class PhotosLoaded extends PhotoState{
  final List<albumPhotoEntity> photos;

  PhotosLoaded(this.photos);
}


class PhotosError extends PhotoState{
  final String message;

  PhotosError(this.message);
}