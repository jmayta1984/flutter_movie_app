import 'package:flutter/material.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = "https://image.tmdb.org/t/p/w92";
  final String defaultImage =
      "https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg";
  int? moviesCount;
  List? movies;
  HttpHelper? helper;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    movies = List.empty();
    movies = await helper?.getUpcoming();
    setState(() {
      moviesCount = movies?.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: (moviesCount == null) ? 0 : moviesCount,
        itemBuilder: ((context, index) {
          if (movies?[index].posterPath != null) {
            image = NetworkImage(iconBase + movies?[index].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }

          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(movies?[index].title),
              subtitle: Text(
                movies?[index].overview,
                maxLines: 2,
              ),
            ),
          );
        }),
      ),
    );
  }
}
