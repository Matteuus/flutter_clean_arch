import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/album/data/models/album.dart';
import 'package:dio/dio.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAllAlbums();
  Future<AlbumModel> getAlbum(int id);
  Future<AlbumModel> updateAlbum(AlbumModel album);
  Future<AlbumModel> deleteAlbum(int id);
  Future<AlbumModel> createAlbum(AlbumModel album);
}

const apiUrlBase = 'https://jsonplaceholder.typicode.com';
const Map<String, String> apiHeaders = {
  'Content-type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
};

class AlbumRemoteDataSouceImpl implements AlbumRemoteDataSource {
  final Dio dio;

  AlbumRemoteDataSouceImpl({required this.dio});

  @override
  Future<AlbumModel> getAlbum(int id) async {
    try {
      final response = await dio.get('$apiUrlBase/albums/$id');
      if (response.statusCode == 200) {
        return AlbumModel.fromJson(response.data);
      } else {
        throw ServerException(
            "Erro, status code " + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException("Falha ao carregar album" + error.toString());
    }
  }

  @override
  Future<List<AlbumModel>> getAllAlbums() async {
    try {
      final response = await dio.get('$apiUrlBase/albums');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((album) => AlbumModel.fromJson(album))
            .toList();
      } else {
        throw ServerException(
            "Erro, status code " + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException("Falha ao carregar album" + error.toString());
    }
  }

  @override
  Future<AlbumModel> createAlbum(album) async {
    try {
      final response = await dio.post('$apiUrlBase/albums',
          data: album.toJson(), options: Options(headers: apiHeaders));
      if (response.statusCode == 201) {
        return AlbumModel.fromJson(response.data);
      } else {
        throw ServerException(
            "Erro, status code " + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException("Falha ao criar album" + error.toString());
    }
  }

  @override
  Future<AlbumModel> deleteAlbum(int id) async {
    try {
      final response = await dio.delete('$apiUrlBase/albums/$id',
          options: Options(headers: apiHeaders));
      if (response.statusCode == 200) {
        return AlbumModel.fromJson(response.data);
      } else {
        throw ServerException(
            "Erro, status code " + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException("Falha ao deletar album" + error.toString());
    }
  }

  @override
  Future<AlbumModel> updateAlbum(album) async {
    try {
      final response = await dio.put(
        '$apiUrlBase/albums/${album.id}',
        options: Options(headers: apiHeaders),
        data: album.toJson(),
      );
      if (response.statusCode == 200) {
        return AlbumModel.fromJson(response.data);
      } else {
        throw ServerException(
            "Erro, status code " + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException("Falha ao atualizar album" + error.toString());
    }
  }
}
