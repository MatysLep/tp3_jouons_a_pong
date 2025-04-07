# TP 3 – Jouons à Pong

## Introduction

Ce projet consiste à développer une application mobile reproduisant le jeu Pong, utilisant Flutter et Dart.

## Présentation du projet

Dans cette application, j'ai implémenté les fonctionnalités suivantes :

- **Animation de la balle :**  
  La balle se déplace de manière continue à l'écran et rebondit sur les bords. Sa trajectoire est modifiée de façon aléatoire à chaque rebond pour varier l'angle et la vitesse.

- **Contrôle de la batte :**  
  L'utilisateur peut déplacer la batte horizontalement via des gestes (glissement) afin de faire rebondir la balle et d'empêcher qu'elle ne touche le bas de l'écran.

- **Gestion du score :**  
  Chaque fois que la balle touche la batte, le score augmente. Un système de sauvegarde du meilleur score est également intégré.

- **Fin de partie et relance :**  
  Si la balle dépasse la zone de la batte, l’animation s’arrête et une boîte de dialogue apparaît pour proposer de rejouer ou de quitter.

- **Système de sauvegarde du meilleur score :**  
  Le meilleur score est sauvegardé localement à l'aide de la librairie shared_preferences.

## Structure du projet

Le projet est organisé en plusieurs fichiers afin de séparer clairement les différentes responsabilités :

- **lib/main.dart**  
  Point d'entrée de l'application.

- **lib/page_principale.dart**  
  Contient la logique principale du jeu, y compris la gestion de l’animation, des collisions et du score.

- **lib/balle.dart**  
  Définit le widget de la balle (sa taille, sa forme, etc.).

- **lib/batte.dart**  
  Définit le widget de la batte, dont la taille s'adapte aux dimensions de l'écran.

- **lib/popup_fin_partie.dart**  
  Gère l’affichage de la boîte de dialogue qui s’ouvre lorsque le joueur perd.

## Émulateur
L'émulateur utilisé était un iPhone 16 Pro.