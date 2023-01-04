import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final _apiKey = '9af3e37b201df44fd5a2f978075cf0b6';
  final _baseUrl = 'api.themoviedb.org';
  final _language = 'es-ES';

  MoviesProvider() {
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
  }

  List<Movie> onDisplayMovies = [];

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    //  final Map<String, dynamic> decodedData = json.decode(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }
}
