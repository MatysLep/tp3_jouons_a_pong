import 'package:flutter/material.dart';

class Balle extends StatelessWidget {
  const Balle({super.key});

  num get DIAMETRE => DIAMETRE;

  @override
  Widget build(BuildContext context) {
    double DIAMETRE = 50;
    return Container(
      width: DIAMETRE,
      height: DIAMETRE,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.yellowAccent,
      ),
    );
  }
}
