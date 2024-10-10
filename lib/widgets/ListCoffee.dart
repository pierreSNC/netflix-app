import 'package:flutter/material.dart';

class Listcoffee extends StatelessWidget {
  const Listcoffee({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deuxième Page'),
      ),
      body: Center(
        child: Text(
          'Bienvenue sur la deuxième page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
