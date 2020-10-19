import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/services/movies_service.dart';

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
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            onPressed: () {},
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
                  return ListTile(
                    isThreeLine: true,
                    contentPadding: EdgeInsets.all(16),
                    leading: Image.network(
                      "https://image.tmdb.org/t/p/w500" +
                          snapshot.data.results[index].poster_path,
                      fit: BoxFit.contain,
                      width: 100,
                    ),
                    title: Text(snapshot.data.results[index].title),
                    subtitle: Text(snapshot.data.results[index].overview),
                  );
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
