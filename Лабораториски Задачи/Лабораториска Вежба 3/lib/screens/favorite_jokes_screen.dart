import 'package:flutter/material.dart';
import '../models/joke.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final List<Joke> favoriteJokes;

  const FavoriteJokesScreen({super.key, required this.favoriteJokes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text('No favorite jokes added.'))
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = favoriteJokes[index];
                return Card(
                  child: ListTile(
                    title: Text(joke.setup),
                    subtitle: Text(joke.punchline),
                  ),
                );
              },
            ),
    );
  }
}
