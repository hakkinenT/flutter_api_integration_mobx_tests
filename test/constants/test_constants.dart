import 'dart:convert';

import 'package:flutter_test_widget_integration_unit/data/models/album.dart';
import 'package:flutter_test_widget_integration_unit/error/http_request_error.dart';

import '../fixtures/fixture_read.dart';

final tAlbums = (json.decode(fixture("album_list.json")) as List)
    .map<Album>((e) => Album.fromJson(e))
    .toList();

final tAlbum = Album.fromJson(json.decode(fixture("album.json")));

const albumToCreate = Album(title: "title 1");

const tId = 1;

const errorMessage = "Alguma coisa deu errado";

final httpError = HttpRequestError(statusCode: 400, message: "Invalid request");

const tAlbumList = <Album>[
  Album(userId: 1, id: 1, title: "title 1"),
  Album(userId: 1, id: 2, title: "title 2"),
  Album(userId: 1, id: 3, title: "title 3")
];
