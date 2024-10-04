import 'package:groq/groq.dart';

class GroqService {
  final groq = Groq(apiKey: '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');

  Future<String> sendMessage(String message, String mode, dynamic language) async {
    // Définir l'instruction pour obtenir uniquement la traduction ou la correction
    String instruction = mode == "translate" && language.isNotEmpty
        ? "Traduis seulement ce texte en $language, sans aucune explication."
        : "Corrige seulement l'orthographe et la grammaire de ce texte, sans aucune explication.";

    groq.startChat();
    GroqResponse response = await groq.sendMessage("$instruction : $message");

    if (response.choices.isNotEmpty) {
      return response.choices.first.message.content.trim(); // Utiliser trim() pour nettoyer la réponse
    }

    return '';
  }
}
