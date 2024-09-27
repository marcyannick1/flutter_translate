import 'package:flutter/material.dart';
import 'translate.dart'; // Importez vos pages
import 'favoris.dart';
import 'homepage.dart';
import 'dart:ui' as ui;

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onItemTapped; // Correction du constructeur

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped, // Ajout du paramètre onItemTapped
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Ajout d'un SafeArea
      child: Stack(
        children: <Widget>[
          // Fond de la barre de navigation avec un effet de vague en haut
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 100, // Augmentation de la hauteur
              decoration: BoxDecoration(
                color: Colors.white, // Changement de la couleur de fond en blanc
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          // Contenu de la barre de navigation
          Container(
            height: 100, // Assurez-vous que la hauteur soit cohérente
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Icône gauche (Favoris)
                IconButton(
                  icon: Icon(Icons.star),
                  iconSize: 28, // Réduction de la taille de l'icône
                  color: selectedIndex == 0 ? Colors.red : Colors.grey,
                  onPressed: () {
                    onItemTapped(0); // Redirection vers Favoris
                  },
                ),
                // Espace pour le bouton Home au centre
                SizedBox(width: 60),
                // Icône droite (Traduction)
                IconButton(
                  icon: Icon(Icons.translate),
                  iconSize: 28, // Réduction de la taille de l'icône
                  color: selectedIndex == 2 ? Colors.red : Colors.grey,
                  onPressed: () {
                    onItemTapped(2); // Redirection vers Translate
                  },
                ),
              ],
            ),
          ),
          // Bouton d'action flottant (Home) centré
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: Container(
              padding: EdgeInsets.all(12), // Padding autour du bouton
              decoration: BoxDecoration(
                color: selectedIndex == 1 ? Colors.redAccent : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0, // Élévation nulle car nous gérons l'ombre dans le container
                onPressed: () {
                  onItemTapped(1); // Redirection vers Home
                },
                child: Icon(
                  Icons.home,
                  size: 32,
                  color: selectedIndex == 1 ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomClipper pour créer une vague (ondulée) en haut de la barre de navigation
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double waveHeight = 30; // Hauteur de la vague

    path.lineTo(0, waveHeight); // Commence un peu plus haut
    path.lineTo(0, size.height);

    var firstControlPoint = Offset(size.width / 4, size.height - waveHeight);
    var firstEndPoint = Offset(size.width / 2, size.height);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height + waveHeight);
    var secondEndPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); // Ferme le chemin
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
