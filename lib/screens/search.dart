import 'package:flutter/material.dart';
import 'package:flutter_api/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../commons/_variables.dart';
import 'movies_details.dart'; // Import de la page MoviesDetails

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.length >= 3) {
      _searchMovies(_searchController.text);
    }
  }

  Future<void> _searchMovies(String query) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        searchResults = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.black,
  appBar: AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
    title: const Text(
      'Search Movies',
      style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon: Image.asset(
          'assets/img/netflix-favicon.png',
          width: 100,
          height: 100,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        },
      ),
    ],
    backgroundColor: Variables.black,
  ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = searchResults[index]['show'];
                        return ListTile(
                          leading: movie['image'] != null
                              ? Image.network(
                                  movie['image']['medium'],
                                  width: 50,
                                  height: 75,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.movie, color: Colors.grey, size: 50),
                          title: Text(
                            movie['name'] ?? 'No Title',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            movie['genres']?.join(', ') ?? 'No Genre',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoviesDetails(seriesId: movie['id']),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
