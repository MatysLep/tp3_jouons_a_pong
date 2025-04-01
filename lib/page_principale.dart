import 'package:flutter/material.dart';
import 'package:tp3_jouons_a_pong/balle.dart';
import 'package:tp3_jouons_a_pong/batte.dart';

class PagePrincipale extends StatefulWidget {
  const PagePrincipale({super.key});

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {
  int _score = 0;

  double largeur = 400;
  double hauteur = 400;
  double posX = 0;
  double posY = 0;
  double largeurBatte = 0;
  double hauteurBatte = 0;
  double positionBatte = 0;

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
                child: Batte(largeur: largeurBatte, hauteur: hauteurBatte),
              ),
            ],
          );
        },
      ),
    );
  }
}
