import 'package:flutter/material.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  final List<String> favoriteMovies;

  const FavoriteMoviesScreen({Key? key, required this.favoriteMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];
          return ListTile(
            title: Text(movie),
            // You can add more details or actions for each favorite movie
          );
        },
      ),
    );
  }
}
