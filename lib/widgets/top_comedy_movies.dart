import 'package:flutter/material.dart';
import 'package:flutter_api/screens/movies_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopComedyMovies extends StatefulWidget {
  const TopComedyMovies({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopComedyMoviesState createState() => _TopComedyMoviesState();
}

class _TopComedyMoviesState extends State<TopComedyMovies> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchComedyMovies();
  }

  Future<void> fetchComedyMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=comedy'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        movies = data.take(10).map((show) => show['show']).toList();
      });
    } else {
      throw Exception('Failed to load comedy movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 32.0),
          child: Text(
            'Top 10 Comedy Movies',
            style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final imageUrl = movie['image'] != null ? movie['image']['medium'] : '';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MoviesDetails(seriesId: movie['id'])),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(imageUrl, fit: BoxFit.cover),
                        )
                      : const Placeholder(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
