import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/album_repository.dart';
import 'presentation/bloc/albums/Bloc.dart';
import 'presentation/bloc/photos/Bloc.dart';
import 'presentation/screens/album_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<albumBloc>(
          create: (context) => albumBloc(
           AlbumRepositoryImpl(),
          ),
        ),
        BlocProvider<PhotosBloc>(
          create: (context) => PhotosBloc(repositoryImpl: AlbumRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        title: 'Album App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AlbumListScreen(),
      ),
    );
  }
}
