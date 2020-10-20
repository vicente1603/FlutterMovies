import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/favorite_bloc.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';

import 'movie_detail.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.lightBlue[200],
      body: StreamBuilder<Map<String, MovieDetailModel>>(
        stream: bloc.outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((movie) {
              return InkWell(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 70.0,
                      child: Image.network("https://image.tmdb.org/t/p/w500" +
                          movie.backdrop_path),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        bloc.toggleFavorite(movie);
                      },
                    )
                  ],
                ),
                onTap: () {
                  MovieDetailModel movieDetail = movie;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MovieDetail(movieDetail)));
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
