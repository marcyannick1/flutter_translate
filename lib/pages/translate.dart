import 'package:flutter/material.dart';
import 'package:flutter_translate/services/groq.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
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
  List<bool> isSelected = [
    true,
    false
  ]; // Par défaut, le mode Traduction est activé.

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800], // Couleur de fond principale
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Barre supérieure avec le texte "translate" et l'icône des paramètres
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "translate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Roboto",
                  ),
                ),
                IconButton.filled(
                  icon: const Icon(Icons.settings),
                  color: Colors.red,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Code pour ouvrir les paramètres
                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              // Affichage des menus déroulants uniquement si le mode "Traduction" est actif
              if (isSelected[0]) // Vérifie si le mode "Traduction" est actif
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Menu déroulant pour la langue d'entrée
                        DropdownButton<String>(
                          value: selectedInputLanguage,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
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
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
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
              const SizedBox(height: 20),

              // ToggleButton pour la sélection du mode Traduction ou Correction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(20),
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
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        mode,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Conteneur avec les champs de texte et les boutons d'action
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Color(0xFFefefef), // Couleur de fond blanche en bas
                ),
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // Champ de texte pour l'entrée
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: TextField(
                            controller: _inputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              filled: true,
                              fillColor: Colors.redAccent,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 50.0, horizontal: 20.0),
                              hintText: isSelected[0]
                                  ? 'Entrez du texte à traduire'
                                  : 'Entrez du texte à corriger',
                              // Change le hintText selon le mode
                              hintStyle:
                                  TextStyle(color: Colors.redAccent[100]),
                            ),
                            maxLines: 4,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Boutons d'action flottants (étoile et envoyer)
                        Positioned(
                          bottom: 30,
                          right: 30,
                          child: Column(
                            children: [
                              IconButton.filled(
                                icon: const Icon(Icons.star_outline),
                                iconSize: 25,
                                padding: const EdgeInsets.all(10),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: () {
                                  // Code pour ajouter à favoris
                                },
                              ),
                              const SizedBox(height: 10),
                              IconButton.filled(
                                icon: const Icon(Icons.send_rounded),
                                iconSize: 25,
                                padding: const EdgeInsets.all(10),
                                color: Colors.redAccent,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                    if (_inputController.text.isNotEmpty) {
                                      setState(() async {
                                        _outputController.text = await GroqService().sendMessage(_inputController.text, isSelected[0] ? "translate" : "correction", isSelected[0] ? selectedOutputLanguage : "");
                                      });
                                    }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Champ de texte pour l'affichage de la traduction ou correction
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _outputController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 50.0, horizontal: 20.0),
                        ),
                        maxLines: 4,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
