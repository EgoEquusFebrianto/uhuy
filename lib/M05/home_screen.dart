import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpHelper? helper;
  List<Movie>? movies;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    initialize();
  }

  Future initialize() async {
    movies = await helper?.getMovies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: movies == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies!.length,
              itemBuilder: (context, position) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(movies![position]),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w92/${movies![position].posterPath}'),
                    ),
                    title: Text(movies![position].title),
                    subtitle: Text(
                      'Released: ${movies![position].releaseDate} - Vote: ${movies![position].voteAverage}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
