import 'package:flutter/material.dart';

class Batte extends StatelessWidget {
  const Batte({super.key, required this.largeur, required this.hauteur});
  final double largeur;
  final double hauteur;

  static const double LARGEUR = 0.3;
  static const double HAUTEUR = 0.02;

  @override
  Widget build(BuildContext context) {
    double _largeur = MediaQuery.of(context).size.width;
    double _hauteur = MediaQuery.of(context).size.height;
    return Container(
      width: _largeur * LARGEUR,
      height: _hauteur * HAUTEUR,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1,
            blurRadius: 9,
            offset: const Offset(0, 3),
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
