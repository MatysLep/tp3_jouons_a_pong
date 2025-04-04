import 'package:flutter/material.dart';
import 'package:tp3_jouons_a_pong/balle.dart';
import 'package:tp3_jouons_a_pong/batte.dart';

enum Direction { haut, bas, gauche, droite }

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
  double largeurBatte = 0;
  double hauteurBatte = 0;
  double positionBatte = 0;

  Direction vDir = Direction.bas;
  Direction hDir = Direction.gauche;

  double increment = 8;

  late Animation animation;
  late AnimationController controleur;

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
        (hDir == Direction.droite) ? posX += increment : posX -= increment;
        (vDir == Direction.bas) ? posY += increment : posY -= increment;
      });
      testerBordures();
    });
    controleur.forward();
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
    } else if (posY >= HAUTEUR - Balle.DIAMETRE * 4) {
      if (posX >= positionBatte && posX <= positionBatte + largeurBatte) {
        _score++;
        vDir = Direction.haut;
      } else {
        controleur.stop();
        dispose();
        afficherMessage(context);
      }
      vDir = Direction.haut;
    }

    if (posX <= 0) {
      hDir = Direction.droite;
    } else if (posX >= LARGEUR - Balle.DIAMETRE) {
      hDir = Direction.gauche;
    }
  }

  Future<dynamic> afficherMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Game Over"),
            content: Text("Votre score est de $_score"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controleur.forward();
                },
                child: Text("Rejouer"),
              ),
            ],
          ),
    );
  }

  void deplacerBatte(DragUpdateDetails maj, BuildContext context) {
    safeSetState(() {
      positionBatte += maj.delta.dx;
    });
  }

  @override
  Widget build(BuildContext context) {
    double LARGEUR = MediaQuery.of(context).size.width;
    double HAUTEUR = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Jeu Pong", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          hauteur = constraints.maxHeight;
          largeur = constraints.maxWidth;
          largeurBatte = largeur / 5;
          hauteurBatte = hauteur / 20;
          return Stack(
            children: [
              Positioned(top: 0, right: 5, child: Text('Score: $_score')),
              Positioned(top: posY, left: posX, child: Balle()),
              Positioned(
                bottom: 10,
                left: positionBatte,
                child: Positioned(
                  bottom: 0,
                  left: positionBatte,
                  child: GestureDetector(
                    onHorizontalDragUpdate:
                        (DragUpdateDetails maj) => deplacerBatte(maj, context),
                    child: Batte(largeur: largeurBatte, hauteur: hauteurBatte),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
