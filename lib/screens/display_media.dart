import 'package:flutter/material.dart';

class DisplayMedia extends StatelessWidget {
  const DisplayMedia({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
              onPressed: () {
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
    );
  }
}