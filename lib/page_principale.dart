import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tp3_jouons_a_pong/balle.dart';
import 'package:tp3_jouons_a_pong/batte.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp3_jouons_a_pong/popup_fin_partie.dart';

enum Direction { haut, bas, gauche, droite }

const String SCORE_MAX = 'Score Max';

class PagePrincipale extends StatefulWidget {
  const PagePrincipale({super.key});

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale>
    with SingleTickerProviderStateMixin {
  int _score = 0;

  double largeur = 400;
  double hauteur = 400;
  double posX = 0;
  double posY = 0;
  double randX = 1;
  double randY = 1;
  double largeurBatte = 0;
  double hauteurBatte = 1;
  double positionBatte = 0;

  Direction vDir = Direction.bas;
  Direction hDir = Direction.gauche;

  double increment = 8;

  late Animation animation;
  late AnimationController controleur;

  int _scoreMax = 0;

  Future<void> lireScoreMax() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? scoreMaxSauvegarde = preferences.getInt(SCORE_MAX);
    if (scoreMaxSauvegarde != null) {
      setState(() {
        _scoreMax = scoreMaxSauvegarde;
      });
    } else {
      preferences.setInt(SCORE_MAX, 0);
      setState(() {
        _scoreMax = 0;
      });
    }
  }

  Future<void> ecrireScoreMax() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    int? scoreMaxSauvegarde = preferences.getInt(SCORE_MAX);
    if (_score > scoreMaxSauvegarde!) {
      preferences.setInt(SCORE_MAX, _score);
      setState(() {
        _scoreMax = _score;
      });
    }
  }

  void initState() {
    posX = 0;
    posY = 0;
    controleur = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controleur);
    animation.addListener(() {
      safeSetState(() {
        (hDir == Direction.droite)
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vDir == Direction.bas)
            ? posY += ((increment * randY).round())
            : posY -= ((increment * randY).round());
      });
      testerBordures();
    });
    controleur.forward();
    lireScoreMax();
    super.initState();
  }

  @override
  void dispose() {
    controleur.dispose();
    super.dispose();
  }

  void safeSetState(Function function) {
    if (mounted && controleur.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void testerBordures() {
    double LARGEUR = MediaQuery.of(context).size.width;
    double HAUTEUR = MediaQuery.of(context).size.height;

    if (posY <= 0) {
      vDir = Direction.bas;
      randX = nombreAleatoire();
    } else if (posY >=
        HAUTEUR - hauteurBatte - HAUTEUR * Batte.HAUTEUR - Balle.DIAMETRE * 4) {
      if (posX >= positionBatte - (Balle.DIAMETRE / 2) &&
          posX <= positionBatte + largeurBatte + (Balle.DIAMETRE / 2)) {
        _score++;
        vDir = Direction.haut;
        randX = nombreAleatoire();
      } else {
        controleur.stop();
        ecrireScoreMax();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return afficherMessage(context, _score, _scoreMax);
          },
        );
      }
      vDir = Direction.haut;
    }

    if (posX <= 0) {
      hDir = Direction.droite;
      randY = nombreAleatoire();
    } else if (posX >= LARGEUR - Balle.DIAMETRE) {
      hDir = Direction.gauche;
      randY = nombreAleatoire();
    }
  }

  Widget afficherMessage(BuildContext context, int score, int scoreMax) {
    return PopupFinPartie(
      score: score,
      scoreMax: scoreMax,
      onRestart: () {
        Navigator.of(context).pop();
        controleur.forward();
        setState(() {
          _score = 0;
          posX = 0;
          posY = 0;
          positionBatte = 0;
        });
      },
      onQuit: () {
        Navigator.of(context).pop();
        dispose();
      },
    );
  }

  void deplacerBatte(DragUpdateDetails maj, BuildContext context) {
    safeSetState(() {
      positionBatte += maj.delta.dx;
      if (positionBatte < 0) {
        positionBatte = 0;
      } else if (positionBatte + largeurBatte > largeur - 40) {
        positionBatte = largeur - largeurBatte * 1.5;
      }
    });
  }

  double nombreAleatoire() {
    return (Random().nextInt(100) + 50) / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jeu Pong",
          style: TextStyle(color: Colors.white, fontFamily: "PressStart2P"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000428),
                Color(0xFF000428),
                Color(0xFF004e92),
                Color(0xFFa044ff),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          hauteur = constraints.maxHeight;
          largeur = constraints.maxWidth;
          largeurBatte = largeur / 5;
          hauteurBatte = hauteur / 20;
          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: const [
                  Color(0xFF000428), // deep navy blue
                  Color(0xFF004e92), // medium blue
                  Color(0xFFa044ff), // vibrant purple
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 5,
                  child: Text(
                    'Score: $_score',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 253, 240, 200),
                      fontSize: 15,
                      fontFamily: "PressStart2P",
                    ),
                  ),
                ),
                Positioned(top: posY, left: posX, child: Balle()),
                Positioned(
                  bottom: hauteurBatte,
                  left: positionBatte,
                  child: GestureDetector(
                    onHorizontalDragUpdate:
                        (DragUpdateDetails maj) => deplacerBatte(maj, context),
                    child: Batte(largeur: largeurBatte, hauteur: hauteurBatte),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
