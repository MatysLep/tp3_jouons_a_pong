import 'package:flutter/material.dart';
import 'package:tp3_jouons_a_pong/page_principale.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion du temps',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SafeArea(child: PagePrincipale()),
    );
  }
}
