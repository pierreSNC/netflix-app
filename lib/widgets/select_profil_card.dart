import 'package:flutter/material.dart';
import '../screens/display_media.dart';

class SelectProfilCard extends StatelessWidget {
  const SelectProfilCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DisplayMedia()),
                );
              }, 
              child: Image.asset(
                'assets/img/profil.jpg',
                height: MediaQuery.of(context).size.width / 3,
              ), 
            ),
            const SizedBox(height: 5),
            const Expanded(
              child: Text(
                'Pierre',
                 style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                )
              )
            ),
          ],
        ),
      ],
    );
  }
}