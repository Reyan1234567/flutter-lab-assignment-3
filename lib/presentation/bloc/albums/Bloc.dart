import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/data/repositories/album_repository.dart';
import 'package:lab4/presentation/bloc/albums/event.dart';
import 'package:lab4/presentation/bloc/albums/state.dart';

class albumBloc extends Bloc<albumEvent, AlbumState>{
  final AlbumRepositoryImpl repositoryImpl;
  albumBloc(this.repositoryImpl):super(AlbumInitial()){
    on<FetchAlbum>(_onFetchAlbum);
  }

  Future<void> _onFetchAlbum(FetchAlbum event, Emitter<AlbumState> emit)async{
    emit(AlbumLoading());

    try{
      final album=await repositoryImpl.getAlbumById(event.id);
      emit(AlbumLoaded(album));
    }
    catch(e){
      emit(AlbumError("Failed to fetch Album:${e.toString()}"));
    }
  }

}