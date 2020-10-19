import 'dart:convert';

MovieDetailModel movieDetailModelFromJson(String str) =>
    MovieDetailModel.fromJson(json.decode(str));

String denunciadoModelToJson(MovieDetailModel data) =>
    json.encode(data.toJson());

class MovieDetailModel {
  double popularity;
  int vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String original_language;
  String original_title;
  List<dynamic> genre_ids;
  String title;
  double vote_average;
  String overview;
  String release_date;

  MovieDetailModel(
      {this.popularity,
      this.vote_count,
      this.video,
      this.poster_path,
      this.id,
      this.adult,
      this.backdrop_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.title,
      this.vote_average,
      this.overview,
      this.release_date});

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      popularity: json["popularity"],
      vote_count: json["vote_count"],
      video: json["video"],
      poster_path: json["poster_path"],
      id: json["id"],
      adult: json["adult"],
      backdrop_path: json["backdrop_path"],
      original_language: json["original_language"],
      original_title: json["original_title"],
      genre_ids: json["genre_ids"],
      title: json["title"],
      vote_average: json["vote_average"],
      overview: json["overview"],
      release_date: json["release_date"],
    );
  }

  Map<String, dynamic> toJson() => {
        "popularity": popularity,
        "vote_count": vote_count,
        "video": video,
        "poster_path": poster_path,
        "id": id,
        "adult": adult,
        "backdrop_path": backdrop_path,
        "original_language": original_language,
        "original_title": original_title,
        "genre_ids": genre_ids,
        "title": title,
        "vote_average": vote_average,
        "overview": overview,
        "release_date": release_date,
      };
}
