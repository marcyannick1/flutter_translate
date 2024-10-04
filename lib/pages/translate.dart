import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'navbar.dart'; // Assurez-vous que CustomBottomNavBar est bien importé

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  _PageTraductionState createState() => _PageTraductionState();
}

class _PageTraductionState extends State<TranslatePage> {
  // Les langues disponibles
  final List<String> languages = [
    'English',
    'French',
    'Spanish',
    'German',
    'Italian'
  ];

  // Langues sélectionnées initialement
  String selectedInputLanguage = 'English';
  String selectedOutputLanguage = 'French';

  // Modes disponibles
  final List<String> modes = ['Traduction', 'Correction'];
  List<bool> isSelected = [true, false]; // Par défaut, le mode Traduction est activé.

  // Index actuel de la page pour la Bottom Navigation Bar
  int _selectedIndex = 0;

  // Fonction pour mettre à jour l'index lorsqu'on clique sur un item de la barre de navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Vous pouvez naviguer vers d'autres pages ici si nécessaire
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800], // Couleur de fond principale
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Change à start pour remonter le contenu
        children: <Widget>[
          // Barre supérieure avec le texte "Translate" et l'icône des paramètres
          Padding(
            padding: const EdgeInsets.all(37.0), // Réduit le padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Translate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Roboto",
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Couleur de fond blanche
                    shape: BoxShape.circle, // Forme circulaire
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    color: Colors.redAccent, // Change la couleur ici
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      // Code pour ouvrir les paramètres
                    },
                  ),
                ),
              ],
            ),
          ),
          // Colonne pour les éléments du contenu
          Expanded( // Utilise Expanded pour prendre l'espace restant
            child: Column(
              children: [
                // Affichage des menus déroulants uniquement si le mode "Traduction" est actif
                if (isSelected[0]) // Vérifie si le mode "Traduction" est actif
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0), // Réduit le padding
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // Réduit les coins arrondis
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4), // décalage de l'ombre
                            blurRadius: 8, // flou de l'ombre
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 29), // Réduit le padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Menu déroulant pour la langue d'entrée
                          DropdownButton<String>(
                            value: selectedInputLanguage,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black, fontSize: 16), // Réduit la taille de la police
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedInputLanguage = newValue!;
                              });
                            },
                            items: languages
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          // Icône de flèche pour échanger les langues
                          IconButton(
                            icon: const Icon(Icons.swap_horiz, color: Colors.red),

                            // Réduit la taille de la police
                            onPressed: () {
                              setState(() {
                                // Inverser les langues sélectionnées
                                String temp = selectedInputLanguage;
                                selectedInputLanguage = selectedOutputLanguage;
                                selectedOutputLanguage = temp;
                              });
                            },
                          ),
                          // Menu déroulant pour la langue de sortie
                          DropdownButton<String>(
                            value: selectedOutputLanguage,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black, fontSize: 16), // Réduit la taille de la police
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOutputLanguage = newValue!;
                              });
                            },
                            items: languages
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 30), // Réduit l'espacement

                // Bande de sélection du mode Traduction ou Correction avec ombre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Réduit le padding
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white, // Réduit les coins arrondis
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4), // décalage de l'ombre
                          blurRadius: 8, // flou de l'ombre
                        ),
                      ],
                    ),
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(15), // Réduit les coins arrondis
                      selectedColor: Colors.white,
                      selectedBorderColor: Colors.redAccent,
                      fillColor: Colors.redAccent,
                      color: Colors.white,
                      borderColor: Colors.redAccent,
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                        });
                      },
                      children: modes.map((String mode) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0), // Réduit le padding
                          child: Text(
                            mode,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected[modes.indexOf(mode)]
                                  ? Colors.white // Couleur blanche si sélectionné
                                  : (mode == 'Traduction' ? Colors.redAccent : Colors.redAccent), // Rouge pour 'Traduction' non sélectionné et blanc pour 'Correction'
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Réduit l'espacement

                // Conteneur avec les champs de texte et les boutons d'action
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Colors.white, // Couleur de fond blanche en bas
                    ),
                    padding: EdgeInsets.only(bottom: 20), // Réduit le padding
                    child: Column(
                      children: [
                        // Champ de texte pour l'entrée avec icônes
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Réduit le padding
                          child: Container(
                            width: double.infinity, // Prend toute la largeur disponible
                            height: 80, // Augmente la hauteur
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(30.0), // Coins arrondis
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0, // Flou de l'ombre
                                  offset: Offset(0, 5), // Décalage de l'ombre
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Entrez du texte à traduire',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(
                                  Icons.star, // Icône d'étoile
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.send, // Icône d'envoi
                                    color: Colors.white,
                                  ),
                                  onPressed: () {

                                    // Logique pour envoyer le texte
                                  },
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), // Réduit le padding
                              ),
                              style: const TextStyle(color: Colors.white), // Texte blanc
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Réduit l'espacement

                        // Champ de texte pour la sortie avec icônes
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Réduit le padding
                          child: Container(
                            width: double.infinity, // Prend toute la largeur disponible
                            height: 80, // Augmente la hauteur
                            decoration: BoxDecoration(
                              color: Colors.blue[400], // Change la couleur pour le champ de sortie
                              borderRadius: BorderRadius.circular(30.0), // Coins arrondis
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0, // Flou de l'ombre
                                  offset: Offset(0, 5), // Décalage de l'ombre
                                ),
                              ],
                            ),
                            child: TextField(
                              readOnly: true, // Champ en lecture seule
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Résultat ici',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(
                                  Icons.done, // Icône de résultat
                                  color: Colors.white,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), // Réduit le padding
                              ),
                              style: const TextStyle(color: Colors.white), // Texte blanc
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
