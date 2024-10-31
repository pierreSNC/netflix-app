import 'package:flutter/material.dart';
import 'package:flutter_api/commons/_variables.dart';
import 'package:flutter_api/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesDetails extends StatefulWidget {
  final int seriesId;

  const MoviesDetails({super.key, required this.seriesId});

  @override
  // ignore: library_private_types_in_public_api
  _MoviesDetailsState createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  Map<String, dynamic>? movieDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/shows/${widget.seriesId}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        movieDetails = data;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Center(
            child: IconButton(
              icon: Image.asset(
                'assets/img/netflix-favicon.png',
                width: 80,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              iconSize: 40.0,
              onPressed: () {
                // Logique pour la recherche
              },
            ),
          ],
          backgroundColor: Variables.black,
          centerTitle: true,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieDetails != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (movieDetails!['image'] != null && movieDetails!['image']['original'] != null)
                        Image.network(
                          movieDetails!['image']['original'],
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      else
                        const SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            'No Image Available',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieDetails!['name'] ?? 'Unknown',
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Genres: ${movieDetails!['genres']?.join(', ') ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Duration: ${movieDetails!['runtime'] != null ? '${movieDetails!['runtime']} mins' : 'N/A'}',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Rating: ${movieDetails!['rating']?['average'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              movieDetails!['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ?? 'No summary available',
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                  'Failed to load movie details',
                  style: TextStyle(color: Colors.white),
                )),
    );
  }
}
