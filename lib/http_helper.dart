import 'dart:io';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlKey = 'api_key=3cae426b920b29ed2fb1c0749f258325';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlPopular = '/popular?';
  final String urlTopRated = '/top_rated?';

  Future<String?> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey;
    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    else {
      return null;
    }
  }
}
