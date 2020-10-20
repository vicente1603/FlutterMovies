import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/movies_bloc.dart';
import 'package:flutter_movies/widgets/movie_tile.dart';

class MovieResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);
    bloc.inSearch.add(null);
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes pesquisados"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: Colors.lightBlue[200],
        child: StreamBuilder(
          stream: bloc.outMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieTile(snapshot.data[index]);
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
