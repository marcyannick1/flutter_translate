import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_translate/pages/translate.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool isTranslate = true;

  @override
  void initState() {
    super.initState();

    // Animation Controller pour gérer la transition
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Durée de la transition
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Boucle de changement de texte toutes les 5 secondes
    _startTextChange();
  }

  void _startTextChange() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 8)); // Délai avant de changer
      setState(() {
        isTranslate = !isTranslate; // Alterner entre Translate et Correction
      });
      _controller.forward(from: 0.0); // Réinitialiser l'animation
      return true; // Continue la boucle
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan dynamique avec bulles
          Background(),
          // Contenu principal
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            key: ValueKey<bool>(isTranslate),
                            children: [
                              Icon(
                                isTranslate
                                    ? Icons.translate
                                    : Icons.assignment_turned_in, // Icône de traduction ou de correction
                                size: 50, // Taille de l'icône
                                color: Colors.white, // Couleur de l'icône
                              ),
                              AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    isTranslate ? 'Translate' : 'Correction',
                                    textStyle: TextStyle(
                                      fontSize: 50.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                    ),
                                    colors: [
                                      Colors.white,
                                      Colors.blue,
                                      Colors.yellow,
                                      Colors.red,
                                    ],
                                  ),
                                ],
                                isRepeatingAnimation: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Translate with voice in all languages',
                            textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            speed: Duration(milliseconds: 50),
                          ),
                          TypewriterAnimatedText(
                            'Traduisez avec la voix dans toutes les langues',
                            textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            speed: Duration(milliseconds: 50),
                          ),
                        ],
                        repeatForever: true,
                        pause: Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Action du bouton pour naviguer vers la page translate
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TranslatePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent, // Changement de couleur du bouton
                        padding: const EdgeInsets.symmetric(
                          horizontal: 62,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800], // Changement ici pour un fond bleu uni
      child: Stack(
        children: [
          // Bulles en bas
          ...List.generate(6, (index) {
            return AnimatedBubble(delay: index * 300, isBottom: true);
          }),
          // Bulles en haut à gauche
          ...List.generate(6, (index) {
            return AnimatedBubble(delay: index * 300, isBottom: false);
          }),
        ],
      ),
    );
  }
}

class AnimatedBubble extends StatefulWidget {
  final int delay;
  final bool isBottom;

  const AnimatedBubble({Key? key, required this.delay, required this.isBottom}) : super(key: key);

  @override
  _AnimatedBubbleState createState() => _AnimatedBubbleState();
}

class _AnimatedBubbleState extends State<AnimatedBubble> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: (MediaQuery.of(context).size.width * (0.1 + 0.8 * (widget.delay / 600))),
          bottom: widget.isBottom
              ? _animation.value + 50 * (widget.delay / 600) // Bulles en bas
              : _animation.value + MediaQuery.of(context).size.height - 200 * (widget.delay / 600), // Bulles en haut
          child: Container(
            width: 60 + widget.delay.toDouble(),
            height: 60 + widget.delay.toDouble(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}