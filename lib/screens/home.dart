import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/favorite_bloc.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/screens/movie_detail.dart';
import 'package:flutter_movies/services/movies_service.dart';
import 'package:flutter_movies/widgets/movie_tile.dart';

import 'favorites.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text(snapshot.data.length.toString());
                }else{
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Favorites()
              ));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {},
          )
        ],
      ),
      body: Container(
        color: Colors.lightBlue[200],
        child: FutureBuilder<MovieModel>(
          future: MovieService.popularMovies(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(height: 2, color: Colors.black);
                },
                itemBuilder: (context, index) {
                  return MovieTile(snapshot.data.results[index]);
                },
                itemCount: snapshot.data.results.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
