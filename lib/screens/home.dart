import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/screens/movie_detail.dart';
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
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                          "https://image.tmdb.org/t/p/w500" +
                              snapshot.data.results[index].poster_path,
                          fit: BoxFit.contain,
                          width: 100,
                        ),
                        SizedBox(height: 15.0),
                        Text(snapshot.data.results[index].title,
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
                        SizedBox(height: 15.0),
                      ],
                    ),
                    subtitle: Text(snapshot.data.results[index].overview, textAlign: TextAlign.justify,),
                    onTap: () {
                      MovieDetailModel movie = snapshot.data.results[index];
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetail(movie)));
                    },
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
