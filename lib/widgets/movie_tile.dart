import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/favorite_bloc.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/screens/movie_detail.dart';

class MovieTile extends StatelessWidget {
  final MovieDetailModel movie;

  MovieTile(this.movie);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return ListTile(
      isThreeLine: true,
      contentPadding: EdgeInsets.all(16),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            "https://image.tmdb.org/t/p/w500" + movie.poster_path,
            fit: BoxFit.contain,
            width: 100,
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Text(movie.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 8.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          StreamBuilder<Map<String, MovieDetailModel>>(
            stream: bloc.outFav,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: Icon(
                    snapshot.data.containsKey(movie.id.toString())
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    bloc.toggleFavorite(movie);
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      subtitle: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
      onTap: () {
        MovieDetailModel movieDetail = movie;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MovieDetail(movieDetail)));
      },
    );
  }
}
