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
        gradient: const RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            Color(0xFFB2FF59), // vert clair
            Color(0xFF76FF03), // vert plus soutenu
          ],
        ),
        border: Border.all(
          color: Colors.white, // simulant la couture d'une balle de tennis
          width: 3,
        ),
      ),
    );
  }
}
