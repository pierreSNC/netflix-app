import 'package:flutter/material.dart';
import '../commons/_variables.dart'; 
import 'list_profil.dart';

class Home extends StatelessWidget {
  const Home({super.key});
   @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Variables.black,
            image: DecorationImage(
              image: AssetImage("assets/img/netflix-logo.png"),
              alignment: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.only(
            bottom: 48.0,
            left: 24.0,
            right: 24.0,
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Center(
              child: Text(
                'Unlimited entertainment, one low price!',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 40,
                ) ,
                textAlign: TextAlign.center,
              ),
              
            ),
              const SizedBox(height: 25),
              
              const Text(
                'All of Netflix, starting at just €9.99.',
                style: TextStyle(
                  color: Variables.gray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListProfil()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Variables.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
                child: const Text(
                  'Get started',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ),
                  ),
              ),
            ],
          ),
        )

      ),
    );
  }
}