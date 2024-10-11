import 'package:flutter/material.dart';
import '../widgets/header_select_profil.dart';
import '../widgets/select_profil_card.dart';

class ListProfil extends StatelessWidget {
  const ListProfil({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          HeaderSelectProfil(),
          Expanded(child: SelectProfilCard())
        ],
      ),
    );
  }
}
