import 'dart:convert';
import 'package:flutter_movies/models/movie_detail_model.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const API_KEY = "19f5325275524d1d4f39fcb8c06a1761";

class MovieService {
  String _search;

  static Future<MovieModel> popularMovies() async {
    try {

      final response = await http.get(
          "https://api.themoviedb.org/3/movie/popular?api_key=${API_KEY}&language=en-US&page=1");

      if (response.statusCode == 200) {
        Map data = json.decode(response.body);

        MovieModel movies = new MovieModel.fromJson(data);

        final moviesDetail = (data["results"] as List)
            .map((i) => new MovieDetailModel.fromJson(i))
            .toList();

        movies.results = moviesDetail;

        return movies;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<MovieDetailModel>> search(String search) async {
    _search = search;

    http.Response response = await http.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=${API_KEY}&language=en-US&page=1");

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<MovieDetailModel> movies = (decoded["results"] as List)
          .map((i) => new MovieDetailModel.fromJson(i))
          .toList();

      if (_search == null) {
        return movies;
      } else {
        List<MovieDetailModel> result =
        movies.where((movie) => movie.title.contains(search)).toList();
        return result;
      }
    } else {
      throw Exception("Fail");
    }
  }
}
