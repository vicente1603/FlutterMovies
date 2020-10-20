import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';
import 'package:flutter_movies/services/movies_service.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc implements BlocBase {
  MovieService api;
  List<MovieDetailModel> movies;

  final StreamController<List<MovieDetailModel>> _moviesController =
      StreamController<List<MovieDetailModel>>.broadcast();
  //
  // final _moviesController =
  // BehaviorSubject<List<MovieDetailModel>>(seedValue: {});

  Stream get outMovies => _moviesController.stream;

  final StreamController<String> _searchController = StreamController<String>();

  Sink get inSearch => _searchController.sink;

  MoviesBloc() {
    api = MovieService();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    _moviesController.sink.add([]);
    movies = await api.search(search);
    _moviesController.sink.add(movies);
  }

  @override
  void dispose() {
    _moviesController.close();
    _searchController.close();
  }
}
