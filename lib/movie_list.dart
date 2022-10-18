import 'package:flutter/material.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String result = "";
  HttpHelper helper = HttpHelper();

  @override
  Widget build(BuildContext context) {
    helper.getUpcoming().then(
      (value) {
        setState(() {
          result = value!;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Text(result),
    );
  }
}
