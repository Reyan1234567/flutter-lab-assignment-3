import 'package:lab4/domain/entity/albumEntity.dart';

abstract class AlbumState{
  AlbumState();
}

class AlbumInitial extends AlbumState{}
class AlbumLoading extends AlbumState{}

class AlbumLoaded extends AlbumState{
  final albumEntity album;

  AlbumLoaded(this.album);
}


class AlbumError extends AlbumState{
  final String message;

  AlbumError(this.message);
}
