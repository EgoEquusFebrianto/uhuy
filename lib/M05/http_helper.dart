import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class HttpHelper {
  final String _urlKey = "?api_key=fdbce446784119fbe5f15f52ab3d29d7";
  final String _urlBase = "https://api.themoviedb.org";

  Future<List<Movie>?> getMovies() async {
    var url = Uri.parse(_urlBase + '/3/movie/now_playing' + _urlKey);
    http.Response result = await http.get(url);
    if (result.statusCode == 200) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List<Movie> movies = moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
