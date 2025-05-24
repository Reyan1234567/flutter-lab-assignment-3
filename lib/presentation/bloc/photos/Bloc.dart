import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/presentation/bloc/photos/events.dart';
import 'package:lab4/presentation/bloc/photos/state.dart';

import '../../../data/repositories/album_repository.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotoState>{
  final AlbumRepositoryImpl repositoryImpl;

  PhotosBloc({required this.repositoryImpl}):super(PhotosInitial()){
    on<FetchPhotos>(_onFetchPhotos);
  }

  Future <void> _onFetchPhotos(FetchPhotos event, Emitter<PhotoState> emit)async {
    emit(PhotosLoading());

    try{
      final photos=await repositoryImpl.getAlbums();
      emit(PhotosLoaded(photos));
    }
    catch(e){
      emit(PhotosError('Failed to fetch joke: ${e.toString()}'));
    }
  }
}