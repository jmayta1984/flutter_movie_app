import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=3cae426b920b29ed2fb1c0749f258325';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlPopular = '/popular?';
  final String urlTopRated = '/top_rated?';

  Future<List?> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey;
    http.Response result = await http.get(Uri.parse(upcoming));

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
