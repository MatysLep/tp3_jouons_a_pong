import 'package:flutter/material.dart';

class PopupFinPartie extends StatelessWidget {
  const PopupFinPartie({
    super.key,
    required this.score,
    required this.scoreMax,
    required this.onRestart,
    required this.onQuit,
  });

  final int score;
  final int scoreMax;
  final VoidCallback onRestart;
  final VoidCallback onQuit;

  final TextStyle titleStyle = const TextStyle(
    fontSize: 16,
    color: Color(0xFF3E2723),
    fontWeight: FontWeight.bold,
    fontFamily: "PressStart2P",
    shadows: [Shadow(color: Colors.white, offset: Offset(1, 1), blurRadius: 2)],
  );

  final TextStyle textStyle = const TextStyle(
    fontSize: 20,
    color: Color(0xFF4E342E),
    fontFamily: "VT323",
  );

  final TextStyle buttonStyle = const TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontFamily: "ShareTechMono-Regular",
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: const [
              Color(0xFFFF5F6D),
              Color(0xFFFFC371),
              Color(0xFFFFF5C3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 9,
              offset: const Offset(0, 3),
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Text("Fin de la partie", style: titleStyle),
            const SizedBox(height: 20),
            Text("Votre score : $score", style: textStyle),
            const SizedBox(height: 5),
            Text("Meilleur score : $scoreMax", style: textStyle),
            const SizedBox(height: 5),
            Text("Souhaitez-vous recommencer ?", style: textStyle),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 25,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3E2723), // dark brown
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    child: Text("Oui", style: buttonStyle),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onQuit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E2723),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    child: Text("Non", style: buttonStyle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
