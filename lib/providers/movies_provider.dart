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
    getPopularMovies();
  }

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final nowPlayingResponse =
        NowPlayingResponse.fromJson(await _getJsonData('3/movie/now_playing'));
    //  final Map<String, dynamic> decodedData = json.decode(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final popularResponse = PopularResponse.fromJson(
        await _getJsonData('3/movie/popular', _popularPage));
    //  final Map<String, dynamic> decodedData = json.decode(response.body);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
