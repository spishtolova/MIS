import 'package:flutter/material.dart';
import '../services/api_services.dart';

class JokeListScreen extends StatelessWidget {
  final String jokeType;

  const JokeListScreen({Key? key, required this.jokeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes: $jokeType'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiServices.getJokesByType(jokeType),
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
              final joke = jokes[index];
              return Card(
                child: ListTile(
                  title: Text(joke['setup']),
                  subtitle: Text(joke['punchline']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
