import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Film',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieList(),
    );
  }
}

class Movie {
  final int id;
  final String title;
  final String category;
  final double rating;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.category,
    required this.rating,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      releaseDate: json['releaseDate'],
    );
  }
}

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(Uri.parse('http://172.22.162.201:8080/movie.json'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    print("Data film berhasil diambil: $jsonList");
    return jsonList.map((json) => Movie.fromJson(json)).toList();
  } else {
    print("Gagal mengambil data film: ${response.statusCode}");
    throw Exception('Failed to load movies');
  }
}

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String selectedCategory = 'Latest';
  List<Movie> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies().then((data) {
      setState(() {
        movies = data;
        isLoading = false;
      });
      print("Data film yang didapat: $movies");
    }).catchError((error) {
      print("Error: $error"); // Debug output
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Film'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: <String>[
                    'Latest',
                    'Now Playing',
                    'Popular',
                    'Top Rated',
                    'Upcoming'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: ListView(
                    children: movies
                        .where((movie) => movie.category == selectedCategory)
                        .map((movie) => ListTile(
                              title: Text(movie.title),
                              subtitle: Text('Rating: ${movie.rating}'),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
