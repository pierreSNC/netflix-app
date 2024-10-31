import 'package:flutter/material.dart';
import 'package:flutter_api/widgets/header_display_media.dart';
import 'package:flutter_api/widgets/main_movie.dart';
import 'package:flutter_api/widgets/top_comedy_movies.dart';
import 'package:flutter_api/widgets/top_horror_movies.dart';
import 'package:flutter_api/widgets/top_romance_movies.dart';
import '../commons/_variables.dart'; 

class DisplayMedia extends StatelessWidget {
  const DisplayMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 24.0,
          top: 24.0,
        ),
        color: Variables.black,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              HeaderDisplayMedia(),
              MainMovie(),
              TopRomanceMovies(),
              TopComedyMovies(),
              TopHorrorMovies()
            ],
          ),
        ),
      ),
    );
  }
}
