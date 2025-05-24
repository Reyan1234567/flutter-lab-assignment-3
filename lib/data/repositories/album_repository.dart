import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repository/album_repository.dart';
import '../models/album_model.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final http.Client _client;
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  AlbumRepositoryImpl({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<Album>> getAlbums() async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/albums'));
      if (response.statusCode == 200) {
        final List<dynamic> albumsJson = json.decode(response.body);
        final List<Album> albums = albumsJson.map((json) => Album.fromJson(json)).toList();
        
        // Fetch photos for each album
        final photosResponse = await _client.get(Uri.parse('$_baseUrl/photos'));
        if (photosResponse.statusCode == 200) {
          final List<dynamic> photosJson = json.decode(photosResponse.body);
          final Map<int, Map<String, dynamic>> photosMap = {};
          
          for (var photo in photosJson) {
            final albumId = photo['albumId'] as int;
            if (!photosMap.containsKey(albumId)) {
              photosMap[albumId] = photo;
            }
          }
          
          // Update albums with photo information
          for (var album in albums) {
            final photo = photosMap[album.id];
            if (photo != null) {
              album = Album(
                id: album.id,
                userId: album.userId,
                title: album.title,
                thumbnailUrl: photo['thumbnailUrl'] as String,
                url: photo['url'] as String,
              );
            }
          }
        }
        
        return albums;
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Error fetching albums: $e');
    }
  }

  @override
  Future<Album> getAlbumById(int id) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/albums/$id'));
      if (response.statusCode == 200) {
        final albumJson = json.decode(response.body);
        final album = Album.fromJson(albumJson);
        
        // Fetch photo for the album
        final photosResponse = await _client.get(Uri.parse('$_baseUrl/photos?albumId=$id'));
        if (photosResponse.statusCode == 200) {
          final List<dynamic> photosJson = json.decode(photosResponse.body);
          if (photosJson.isNotEmpty) {
            final photo = photosJson.first;
            return Album(
              id: album.id,
              userId: album.userId,
              title: album.title,
              thumbnailUrl: photo['thumbnailUrl'] as String,
              url: photo['url'] as String,
            );
          }
        }
        
        return album;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception('Error fetching album: $e');
    }
  }
} 