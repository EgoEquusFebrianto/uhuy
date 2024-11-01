import 'package:flutter/material.dart';
import 'movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  const DetailScreen(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = (movie.posterPath.isNotEmpty)
        ? imgPath + movie.posterPath
        : 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height / 1.5,
                child: Image.network(path),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(movie.overview),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
