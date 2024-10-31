import 'package:flutter/material.dart';
import 'package:flutter_api/screens/movies_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainMovie extends StatelessWidget {
  const MainMovie({super.key});

  Future<Map<String, dynamic>?> fetchSeriesDetails() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/shows/169'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load series details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchSeriesDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          final imageUrl = data['image']['medium'];
          final genres = data['genres'].join(', ');
    
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesDetails(seriesId: data['id']),
                ),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Image.network(
                    imageUrl,
                    width: 350,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  genres,
                  style: const TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        } else {
          return const Text('No data found');
        }
      },
    );
  }
}


