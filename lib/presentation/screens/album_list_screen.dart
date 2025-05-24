import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lab4/domain/entity/albumEntity.dart';
import 'package:lab4/presentation/bloc/photos/Bloc.dart';
import 'package:lab4/presentation/bloc/photos/events.dart';
import 'package:lab4/presentation/bloc/photos/state.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: BlocBuilder<PhotosBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotosInitial) {
            context.read<PhotosBloc>().add(FetchPhotos());
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhotosLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhotosLoaded) {
            return _buildAlbumList(context, state.photos);
          } else if (state is PhotosError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PhotosBloc>().add(FetchPhotos());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAlbumList(BuildContext context, List<albumPhotoEntity> albums) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: album.url != null
                ? Image.network(
                    album.url!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported);
                    },
                  )
                : const Icon(Icons.album),
            title: Text(album.title),
            subtitle: Text('Album ID: ${album.id}'),
            onTap: () {
              context.go('/album/${album.id}');
            },
          ),
        );
      },
    );
  }
} 