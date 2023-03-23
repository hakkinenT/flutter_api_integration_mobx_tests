import 'package:dartz/dartz.dart';
import 'package:flutter_test_widget_integration_unit/data/datasources/album_remote_data_source.dart';
import 'package:flutter_test_widget_integration_unit/data/models/album.dart';
import 'package:flutter_test_widget_integration_unit/error/exception/http_request_exception.dart';

import '../../error/failure/failure.dart';

abstract class AlbumRepository {
  Future<Either<Failure, Unit>> create(Album album);
  Future<Either<Failure, Album>> fetchById(int albumId);
  Future<Either<Failure, List<Album>>> fetchAll();
}

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;

  AlbumRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> create(Album album) async {
    try {
      await remoteDataSource.create(album);
      return const Right(unit);
    } on HttpRequestException catch (e) {
      return Left(PostRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Album>>> fetchAll() async {
    try {
      final albums = await remoteDataSource.fetchAll();
      return Right(albums);
    } on HttpRequestException catch (e) {
      return Left(GetRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Album>> fetchById(int albumId) async {
    try {
      final album = await remoteDataSource.fetchById(albumId);
      return Right(album);
    } on HttpRequestException catch (e) {
      return Left(GetRequestFailure(message: e.toString()));
    }
  }
}
