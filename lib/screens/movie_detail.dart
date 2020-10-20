import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_detail_model.dart';

class MovieDetail extends StatelessWidget {
  MovieDetailModel movie;

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      appBar: AppBar(
        title: Text("Detalhes do filme"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500" + movie.backdrop_path,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  alignment: Alignment.center,
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
                          fontSize: 50,
                          fontWeight: FontWeight.bold))),
              Row(children: <Widget>[
                MainInfoTab(
                  fieldTitle: "Popularidade",
                  fieldInfo: movie.popularity.toString(),
                )
              ]),
              Row(children: <Widget>[
                MainInfoTab(
                  fieldTitle: "Idioma Original",
                  fieldInfo: movie.original_language,
                )
              ]),
              // Row(children: <Widget>[
              //   MainInfoTab(
              //     fieldTitle: "Nota",
              //     fieldInfo: movie.vote_average.toString(),
              //   )
              // ]),
              Row(children: <Widget>[
                MainInfoTab(
                  fieldTitle: "Data de lançamento",
                  fieldInfo: movie.release_date,
                )
              ]),
              Row(children: <Widget>[
                MainInfoTab(
                  fieldTitle: "Quantidade de votos",
                  fieldInfo: movie.vote_count.toString(),
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Text("Descrição",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 15),
              Row(children: <Widget>[
                Expanded(
                    child: Text(
                  movie.overview,
                  style: TextStyle(fontSize: 17, color: Colors.black38),
                ))
              ]),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  MainInfoTab({Key key, @required this.fieldTitle, @required this.fieldInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 70,
      child: ListView(
        padding: EdgeInsets.only(top: 15),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            fieldTitle,
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            fieldInfo,
            style: TextStyle(fontSize: 17, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
