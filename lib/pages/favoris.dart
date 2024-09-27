import 'package:flutter/material.dart';
import 'package:flutter_translate/pages/homepage.dart';
import 'package:intl/intl.dart';
import 'navbar.dart'; // Assurez-vous d'importer votre fichier navbar.dart ici

class FavorisPage extends StatefulWidget {
  const FavorisPage({Key? key}) : super(key: key);

  @override
  _FavorisPageState createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // L'onglet Favoris est actif par défaut

  final List<IconData> _icons = [
    Icons.star, // Favoris
    Icons.home, // Home
    Icons.refresh, // Reload
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      // Reste sur la page Favoris
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/home'); // Naviguer vers la page d'accueil
    } else if (index == 2) {
      // Recharge la page actuelle
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FavorisPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Background(), // Arrière-plan dégradé
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Vos traductions favorites',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blue, // Couleur principale
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: const [
                      FavoriteCard(
                        dateTime: '2024-07-23 10:45',
                        language: 'English',
                        translationEn: 'Hello, how are you?',
                        translationFr: 'Bonjour, comment ça va ?',
                      ),
                      FavoriteCard(
                        dateTime: '2024-07-25 14:30',
                        language: 'Français',
                        translationEn: 'Nice to meet you.',
                        translationFr: 'Enchanté de vous rencontrer.',
                      ),
                      FavoriteCard(
                        dateTime: '2024-07-24 09:00',
                        language: 'Español',
                        translationEn: 'Good morning.',
                        translationFr: 'Bonjour.',
                      ),
                      FavoriteCard(
                        dateTime: '2024-07-23 17:15',
                        language: 'Deutsch',
                        translationEn: 'What is your name?',
                        translationFr: 'Comment vous appelez-vous ?',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar( // Intégration du CustomBottomNavBar
        selectedIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// Classe pour l'arrière-plan dynamique
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[300]!,
            Colors.blue[200]!,
            Colors.blue[100]!,
            Colors.blue[50]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}

// Classe pour les cartes de favoris
class FavoriteCard extends StatelessWidget {
  final String dateTime;
  final String language;
  final String translationEn;
  final String translationFr;

  const FavoriteCard({
    Key? key,
    required this.dateTime,
    required this.language,
    required this.translationEn,
    required this.translationFr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Formatage de la date et de l'heure
    DateTime parsedDate = DateTime.parse(dateTime);
    String formattedDate = DateFormat('d MMMM, yyyy - HH:mm').format(parsedDate);

    return Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icône de traduction à gauche
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20), // Padding horizontal
                ),
                Icon(
                  Icons.translate, // Icône de traduction
                  color: Colors.grey, // Couleur de l'icône
                  size: 24,
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translationEn,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800], // Couleur principale
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    translationFr,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.star, // Icône d'étoile dorée
                color: Colors.amber, // Couleur dorée
              ),
              onPressed: () {
                // Action pour marquer le favori (non implémentée)
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FavorisPage(),
    routes: {
      '/': (context) => Homepage(), // Ajoutez votre page d'accueil ici
    },
  ));
}
