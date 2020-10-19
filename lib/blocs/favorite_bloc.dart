import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, MovieDetailModel> _favorites = {};

  final _favController =
  BehaviorSubject<Map<String, MovieDetailModel>>(seedValue: {});

  Stream<Map<String, MovieDetailModel>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")).map((k, v) {
          return MapEntry(k, MovieDetailModel.fromJson(v));
        }).cast<String, MovieDetailModel>();
        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(MovieDetailModel movie) {
    if (_favorites.containsKey(movie.id.toString()))
      _favorites.remove(movie.id.toString());
    else
      _favorites[movie.id.toString()] = movie;

    _favController.sink.add(_favorites);
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
