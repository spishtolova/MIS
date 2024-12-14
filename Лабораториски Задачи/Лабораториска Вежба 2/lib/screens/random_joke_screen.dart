import 'package:flutter/material.dart';
import '../services/api_services.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  late Future<Map<String, dynamic>> _randomJoke;

  @override
  void initState() {
    super.initState();
    _randomJoke = ApiServices.getRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke of the Day'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _randomJoke,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final joke = snapshot.data!;
              return Container(
                margin: const EdgeInsets.all(16.0), 
                padding: const EdgeInsets.all(16.0), 
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(15.0), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), 
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), 
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      joke['setup'], 
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      joke['punchline'], 
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      backgroundColor: Colors.pink[100], 
    );
  }
}
