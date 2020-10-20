import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/favorite_bloc.dart';
import 'package:flutter_movies/blocs/movies_bloc.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/screens/movie_results.dart';
import 'package:flutter_movies/services/movies_service.dart';
import 'package:flutter_movies/widgets/movie_search.dart';
import 'package:flutter_movies/widgets/movie_tile.dart';

import 'favorites.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);
    bloc.inSearch.add(null);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Movies"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, MovieDetailModel>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.length.toString());
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            tooltip: "Lista de favoritos",
            icon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
          IconButton(
            tooltip: "Pesquisar filme",
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: MovieSearch());
              if (result != null) {
                bloc.inSearch.add(result);
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => MovieResults()));
              }
            },
          )
        ],
      ),
      body: Container(
        color: Colors.lightBlue[200],
        child: StreamBuilder(
          stream: bloc.outMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return MovieTile(snapshot.data[index]);
                  } else if (index > 1) {
                    bloc.inSearch.add(null);
                    return Container(
                        height: 40.0,
                        width: 40.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ));
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
