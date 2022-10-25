import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=3cae426b920b29ed2fb1c0749f258325';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlPopular = '/popular?';
  final String urlTopRated = '/top_rated?';

  final String urlSearchBase = 'https://api.themoviedb.org/3/search/movie?';
  final String urlQuery = '&query=';

  Future<List?> findMovies(String title) async{
    final String url = urlSearchBase + urlKey + urlQuery + title;
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List?> getUpcoming() async {
    final String url = urlBase + urlUpcoming + urlKey;
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
