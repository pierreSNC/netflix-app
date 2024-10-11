import 'package:flutter/material.dart';
import 'package:flutter_api/screens/home.dart';

class HeaderSelectProfil extends StatelessWidget {
  const HeaderSelectProfil({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 64.0),
                child: Center(
                  child: Image.asset(
                    'assets/img/netflix-logo.png', 
                    width: MediaQuery.of(context).size.width / 2, 
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Text("Who's Watching?", style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
        ),
        const SizedBox(height: 20),
      ],
    );

  }

}