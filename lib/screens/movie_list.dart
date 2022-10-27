import 'package:flutter/material.dart';
import 'package:flutter_movie_app/screens/movie_detail.dart';
import '../models/movie.dart';
import '../utils/db_helper.dart';
import '../utils/http_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int? moviesCount;
  List? movies;
  HttpHelper? helper;

  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies');

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

  Future search(String title) async {
    movies = await helper?.findMovies(title);
    setState(() {
      moviesCount = movies?.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                    onSubmitted: (value) => search(value),
                  );
                } else {
                  setState(() {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text('Movies');
                  });
                }
              });
            },
            icon: visibleIcon,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: (moviesCount == null) ? 0 : moviesCount,
        itemBuilder: ((context, index) {
          return MovieItem(movies![index]);
        }),
      ),
    );
  }
}

class MovieItem extends StatefulWidget {
  final Movie movie;
  const MovieItem(this.movie, {super.key});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  late bool favorite;
  late NetworkImage image;
  late DbHelper dbHelper;

  final String iconBase = "https://image.tmdb.org/t/p/w92";
  final String defaultImage =
      "https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg";
  
  @override
  void initState() {
    favorite = false;
    dbHelper = DbHelper();
    isFavorite();
    super.initState();
  }


  Future isFavorite() async {
    await dbHelper.openDb();
    final result = await dbHelper.isFavorite(widget.movie);
    setState(() {
      favorite = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movie.posterPath != null) {
      image = NetworkImage(iconBase + widget.movie.posterPath!);
    } else {
      image = NetworkImage(defaultImage);
    }
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (_) => MovieDetail(widget.movie));
          Navigator.push(context, route);
        },
        trailing: IconButton(
          icon: Icon(Icons.favorite,
              color: favorite ? Colors.deepOrange : Colors.grey),
          onPressed: () {
            favorite?dbHelper.delete(widget.movie): dbHelper.insert(widget.movie);
            setState(() {
              favorite = !favorite;
            });
          },
        ),
        leading: CircleAvatar(
          backgroundImage: image,
        ),
        title: Text(widget.movie.title!),
        subtitle: Text(
          widget.movie.overview!,
          maxLines: 2,
        ),
      ),
    );
  }
}
