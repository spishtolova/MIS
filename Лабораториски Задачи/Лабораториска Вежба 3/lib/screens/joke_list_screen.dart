import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';
import 'favorite_jokes_screen.dart';

class JokeListScreen extends StatefulWidget {
  final String jokeType;

  const JokeListScreen({super.key, required this.jokeType});

  @override
  State<JokeListScreen> createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  late Future<List<dynamic>> _jokes;
  List<Joke> _favoriteJokes = []; 

  @override
  void initState() {
    super.initState();
    _jokes = ApiServices.getJokesByType(widget.jokeType);
  }

  void _toggleFavorite(Joke joke) {
    setState(() {
      if (_favoriteJokes.contains(joke)) {
        _favoriteJokes.remove(joke);
      } else {
        _favoriteJokes.add(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes: ${widget.jokeType}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteJokesScreen(favoriteJokes: _favoriteJokes),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No jokes available.'));
          }

          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = Joke.fromJson(jokes[index]);
              return Card(
                child: ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(
                      _favoriteJokes.contains(joke)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _favoriteJokes.contains(joke) ? Colors.red : null,
                    ),
                    onPressed: () => _toggleFavorite(joke),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
