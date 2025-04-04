import 'package:flutter/material.dart';

class Balle extends StatelessWidget {
  const Balle({super.key});

  static const double DIAMETRE = 50;

  @override
  Widget build(BuildContext context) {
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
