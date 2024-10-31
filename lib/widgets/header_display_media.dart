import 'package:flutter/material.dart';
import 'package:flutter_api/screens/home.dart';

class HeaderDisplayMedia extends StatelessWidget {
  const HeaderDisplayMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Image.asset(
            'assets/img/netflix-favicon.png',
            width: 100,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          iconSize: 40.0,
          onPressed: () {
           
          },
        ),
      ],
    );
  }
}