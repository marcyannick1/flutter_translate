import 'package:groq/groq.dart';

class GroqService {
  final groq = Groq(apiKey: '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');

  Future<String> sendMessage(String message, String mode, dynamic language) async {
    String instruction = mode == "translate" && language.isNotEmpty ? "Repond seulement que par la traduction de ce texte en $language" : "Repond seulement que par la correction d'orthographe de ce texte";
    groq.startChat();
    GroqResponse response = await groq.sendMessage("$instruction : $message");

    if (response.choices.isNotEmpty) {
      return response.choices.first.message.content;
    }

    return '';
  }
}
