import 'package:flutter_test_widget_integration_unit/controllers/album_controller.dart';
import 'package:flutter_test_widget_integration_unit/data/datasources/album_remote_data_source.dart';
import 'package:flutter_test_widget_integration_unit/data/repositories/album_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  sl.registerFactory(
    () => AlbumController(repository: sl()),
  );

  sl.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AlbumRemoteDataSource>(
    () => AlbumRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton(
    () => http.Client(),
  );
}
