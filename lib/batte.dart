import 'package:flutter/material.dart';

class Batte extends StatelessWidget {
  const Batte({super.key, required this.largeur, required this.hauteur});
  final double largeur;
  final double hauteur;

  @override
  Widget build(BuildContext context) {
    double LARGEUR = MediaQuery.of(context).size.width;
    double HAUTEUR = MediaQuery.of(context).size.height;
    return Container(
      width: LARGEUR * 0.3,
      height: HAUTEUR * 0.02,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
