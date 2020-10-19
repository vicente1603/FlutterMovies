import 'dart:convert';

import 'package:flutter_movies/models/movie_detail_model.dart';

MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

class MovieModel {
  int page;
  int total_results;
  int total_pages;
  List<MovieDetailModel> results;

  MovieModel({this.page, this.total_results, this.total_pages, this.results});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      page: json["page"],
      total_results: json["total_results"],
      total_pages: json["total_pages"],
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "total_results": total_results,
    "total_pages": total_pages,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}
