import 'package:flutter/material.dart';
import 'movie_list.dart';

void main() {
  runApp(const MyMovies());
}

class MyMovies extends StatelessWidget {
  const MyMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My movies",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MovieList();
  }
}
